function clockwise(cur_player::AbstractPlayer)
  cur_piece = cur_player.piece
  cur_grid = cur_player.grid

  did_move = rotate!(cur_player, cur_piece, cur_grid, +1)

  did_move
end
