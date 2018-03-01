function step(cur_player::AbstractPlayer)
  if isnull(cur_player.piece)
    summon_piece!(cur_player)

    check(cur_player.piece, cur_player.grid) ||
      raise_defeat(cur_player)
  end

  down(cur_player)
end
