function step(cur_player::AbstractPlayer)
  isnull(cur_player.piece) ||
    return down(cur_player)

  summon_piece!(cur_player)

  if !check(cur_player.piece, cur_player.grid)
    raise_defeat(cur_player)
    return false
  end

  if !down(cur_player)
    raise_defeat(cur_player)
    return false
  end

  true
end
