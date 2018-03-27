function step(cur_player::AbstractPlayer)
  isnull(cur_player.piece) ||
    return slow_drop(cur_player, true)

  summon_piece!(cur_player) ||
    return end_round(cur_player)

  slow_drop(cur_player, true)
end
