function drag_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.drag = cur_uuid

  @async while check_clock(cur_player)

    sleep(4)

    isnull( cur_player.clock.drag ) && break

    ( cur_player.clock.drag == cur_uuid ) || break

    glue_piece!(cur_player)
    break

  end

end
