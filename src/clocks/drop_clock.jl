function drop_clock(cur_player::AbstractPlayer)

  ( cur_player.game.in_focus ) || return

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.drop = cur_uuid

  @async while cur_player.state.is_playing && !cur_player.state.has_lost && cur_player.clock.drop == cur_uuid
    did_step = step(cur_player)

    if did_step
      sleep(0.5)
      continue
    end

    cur_player.clock.drop =
      Nullable{Base.Random.UUID}()

    lock_clock(cur_player)
    break
  end

end
