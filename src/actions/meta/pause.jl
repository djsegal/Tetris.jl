function pause(cur_player::AbstractPlayer)
  cur_state = cur_player.state

  is_paused = !cur_state.is_playing && !cur_state.has_lost

  cur_state.is_playing = !cur_state.is_playing

  is_paused && drop_clock(cur_player)

  return
end
