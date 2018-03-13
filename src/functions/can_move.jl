function can_move(cur_player::AbstractPlayer)
  cur_player.game.in_focus || return false
  cur_player.state.is_playing || return false

  return true
end
