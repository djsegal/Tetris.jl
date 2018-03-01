function check(cur_blocks::Vector{Tuple{Int,Int}}, cur_grid::AbstractGrid)
  for (cur_row, cur_col) in cur_blocks
    ( cur_col <= 0 ) && return false
    ( cur_row <= 0 ) && return false

    ( cur_col > cur_grid.cols ) && return false

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

