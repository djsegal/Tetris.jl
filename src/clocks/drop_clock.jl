function drop_clock(cur_player::AbstractPlayer)

  ( cur_player.game.in_focus ) || return

  isnull(cur_player.clock.push) &&
    push_clock(cur_player)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.drop = cur_uuid

  cur_player.clock.lock =
    Nullable{Base.Random.UUID}()

  cur_level = cur_player.level

  cur_sleep_time = 0.85

  cur_sleep_time ^= cur_level

  cur_sleep_time *= 725

  cur_sleep_time += cur_level

  cur_sleep_time /= 1000

  @async while check_clock(cur_player, :drop, cur_uuid)
    did_step = step(cur_player)

    if did_step
      cur_player.clock.lock =
        Nullable{Base.Random.UUID}()
    else
      isnull(cur_player.clock.lock) &&
        lock_clock(cur_player)

      isnull(cur_player.clock.drag) &&
        drag_clock(cur_player)
    end

    sleep(cur_sleep_time)
  end

end
