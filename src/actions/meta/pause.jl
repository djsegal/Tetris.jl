function pause(cur_player::AbstractPlayer)
  cur_player.game.in_focus || return

  cur_state = cur_player.state

  cur_state.has_lost && return

  is_paused = !cur_state.is_playing

  cur_state.is_playing = !cur_state.is_playing

  is_paused && drop_clock(cur_player)

  return
end
