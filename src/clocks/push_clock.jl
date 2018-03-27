function push_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.push = cur_uuid

  @async while cur_player.state.is_playing && !cur_player.state.is_done && cur_player.clock.push == cur_uuid && cur_player.round.is_keeping_score

    sleep(10)

    send_logs(cur_player)

  end

end
