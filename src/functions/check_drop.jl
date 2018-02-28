function check_drop(cur_piece::AbstractPiece)
  cur_grid = cur_piece.owner.grid

  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)
    cur_row -= 1

    iszero(cur_row) && return false

    has_collision = cur_grid.table[cur_row, cur_col]
    has_collision && return false
  end

  true
end
