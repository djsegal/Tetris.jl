function drop_clock(cur_player::AbstractPlayer)

  ( cur_player.game.in_focus ) || return

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.drop = cur_uuid

  cur_player.clock.lock =
    Nullable{Base.Random.UUID}()

  @async while cur_player.state.is_playing && !cur_player.state.has_lost && cur_player.clock.drop == cur_uuid
    did_step = step(cur_player)

    if did_step
      cur_player.clock.lock =
        Nullable{Base.Random.UUID}()
    else
      isnull(cur_player.clock.lock) &&
        lock_clock(cur_player)
    end

    sleep(0.5)
  end

end
