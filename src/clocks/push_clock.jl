function push_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.push = cur_uuid

  zero_seconds = Base.Dates.Millisecond(0)

  total_time = Base.Dates.Millisecond(12000)

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

    sleep_time = total_time - time_diff

    if sleep_time > zero_seconds
      sleep(sleep_time)
    else
      sleep(1)
    end


  end

end
