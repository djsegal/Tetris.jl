function lock_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.lock = cur_uuid

  max_time = Base.Dates.Millisecond(500)

  wait_time = max_time

  start_now = now()

  @async while cur_player.state.is_playing && !cur_player.state.has_lost && cur_player.clock.lock == cur_uuid
    cur_time = max(
      start_now,
      cur_player.clock.last_move
    )

    time_diff = ( now() - cur_time )

    if time_diff < max_time
      sleep(max_time - time_diff)
      continue
    end

    glue_piece!(cur_player)
    drop_clock(cur_player)
    break
  end

end
