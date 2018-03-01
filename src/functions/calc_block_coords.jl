function calc_block_coords(cur_block::AbstractBlock, cur_rotation::Int=0)

  @assert cur_rotation in [ 0 , -1 , +1 ]

  cur_piece = cur_block.piece

  if iszero(cur_rotation)
    cur_row = cur_block.y
    cur_col = cur_block.x
  else
    cur_row = cur_block.x
    cur_col = cur_block.y

    cur_row *= -sign(cur_rotation)
    cur_col *= +sign(cur_rotation)
  end

  if iseven(cur_piece.width)
    ( cur_row < 0 ) && ( cur_row += 1 )
    ( cur_col < 0 ) && ( cur_col += 1 )
  end

  cur_row += cur_piece.i
  cur_col += cur_piece.j

  return (cur_row, cur_col)

end
