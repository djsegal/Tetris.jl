function up(cur_player::AbstractPlayer)
  cur_piece = cur_player.piece
  cur_grid = cur_player.grid

  max_rows = cur_grid.rows
  max_rows += cur_grid.hidden_rows
  max_rows += 1 # for safe measure

  did_move = drop!(cur_piece, cur_grid, -max_rows)

  did_move
end
