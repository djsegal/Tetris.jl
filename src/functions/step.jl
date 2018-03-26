function step(cur_player::AbstractPlayer)
  isnull(cur_player.piece) ||
    return down(cur_player, true)

  summon_piece!(cur_player) ||
    return end_round(cur_player)

  down(cur_player, true)
end
