function pin_piece!(cur_piece::AbstractPiece)
  cur_player = cur_piece.owner

  cur_piece.i = cur_player.grid.rows
  cur_piece.j = cur_player.grid.cols / 2

  isodd(cur_piece.width) && ( cur_piece.i += 1 )
  ( cur_piece.width == 2 ) && ( cur_piece.i += 1 )

  return
end
