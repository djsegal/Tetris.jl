function push_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.push = cur_uuid

  one_second = Base.Dates.Millisecond(1000)

  total_time = 5 * one_second

  min_logs = 10

  @async while cur_player.round.is_keeping_score && check_clock(cur_player, :push, cur_uuid)

    if length(cur_player.round.logs) < min_logs
      sleep(total_time)
      continue
    end

    init_time = now()

    send_logs(cur_player)

    time_diff = now() - init_time

    sleep_time = max(
      one_second,
      total_time - time_diff
    )

    sleep(sleep_time)

  end

end
