function push_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.push = cur_uuid

  one_second = Base.Dates.Millisecond(1000)

  sleep_time = 5 * one_second

  min_logs = 10

  @async while cur_player.round.is_keeping_score && check_clock(cur_player, :push, cur_uuid)

    init_logs = length(cur_player.round.logs)

    if init_logs < min_logs
      sleep(sleep_time)
      continue
    end

    send_logs(cur_player)

    logs_diff = init_logs - length(cur_player.round.logs)

    tetris_js(
      cur_player.game.scope,
      JSString("""
        console.log("Sent $(logs_diff) logs to score api.");
      """)
    )

    sleep(sleep_time)

  end

end
