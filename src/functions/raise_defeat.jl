function raise_defeat(cur_player::AbstractPlayer)
  cur_player.state.is_playing = false
  cur_player.state.has_lost = true

  evaljs(
    cur_player.game.scope,
    js"alert('You lost :(')"
  )
end
