function slide_left(cur_player::AbstractPlayer)
  cur_piece = cur_player.piece
  cur_grid = cur_player.grid

  did_move = slide!(cur_player, cur_piece, cur_grid, -1)

  did_move
end
