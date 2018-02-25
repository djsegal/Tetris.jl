function calc_block_coords(cur_block::AbstractBlock)

  cur_piece = cur_block.piece

  cur_row = cur_block.y
  cur_col = cur_block.x

  if iseven(cur_piece.width)
    ( cur_row < 0 ) && ( cur_row += 1 )
    ( cur_col < 0 ) && ( cur_col += 1 )
  end

  cur_row += cur_piece.i
  cur_col += cur_piece.j

  return (cur_row, cur_col)

end
