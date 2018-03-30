function push_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.push = cur_uuid

  five_seconds = Base.Dates.Millisecond(5000)

  total_time = 3 * five_seconds

  is_first_call = true

  @async while cur_player.round.is_keeping_score && check_clock(cur_player, :push, cur_uuid)

    if is_first_call
      is_first_call = false

      sleep( total_time / 2 )
      continue
    end

    init_time = now()

    send_logs(cur_player)

    time_diff = now() - init_time

    sleep_time = max(
      five_seconds,
      total_time - time_diff
    )

    sleep(sleep_time)

  end

end
