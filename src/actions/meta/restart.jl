function restart(cur_player::AbstractPlayer)
  raise_defeat(cur_player)
  play(cur_player)

  return
end
