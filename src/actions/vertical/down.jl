function down(cur_player::AbstractPlayer)
  cur_piece = cur_player.piece
  cur_grid = cur_player.grid

  did_move = drop!(
    cur_player, cur_piece, cur_grid,
    -1, true
  )

  did_move
end
