function drag_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.drag = cur_uuid

  @async while cur_player.state.is_playing && !cur_player.state.is_done

    sleep(4)

    isnull( cur_player.clock.drag ) && break

    ( cur_player.clock.drag == cur_uuid ) || break

    glue_piece!(cur_player)
    break

  end

end
