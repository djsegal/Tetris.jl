function check(cur_blocks::Vector{Tuple{Int,Int}}, cur_grid::AbstractGrid, cur_offsets::Tuple{Int,Int}=(0,0))
  cur_col_offset, cur_row_offset = cur_offsets

  for (cur_row, cur_col) in cur_blocks
    cur_row += cur_row_offset
    cur_col += cur_col_offset

    ( cur_col <= 0 ) && return false
    ( cur_row <= 0 ) && return false

    total_rows = cur_grid.rows + cur_grid.hidden_rows

    ( cur_col > cur_grid.cols ) && return false
    ( cur_row > total_rows ) && return false

    has_collision = ( cur_grid.table[cur_row, cur_col] != "" )
    has_collision && return false
  end

  true
end

function check(cur_piece::AbstractPiece, cur_grid::AbstractGrid)
  cur_blocks = map(
    cur_block -> calc_block_coords(cur_block),
    cur_piece.blocks
  )

  check(cur_blocks, cur_grid)
end

