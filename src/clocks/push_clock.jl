function push_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.push = cur_uuid

  @async while cur_player.round.is_keeping_score && check_clock(cur_player, :push, cur_uuid)

    sleep(10)

    send_logs(cur_player)

  end

end
