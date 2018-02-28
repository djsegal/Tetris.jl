function check(cur_blocks::Vector{Tuple{Int,Int}}, cur_grid::AbstractGrid)
  for (cur_row, cur_col) in cur_blocks
    iszero(cur_col) && return false
    iszero(cur_row) && return false

    ( cur_col > cur_grid.cols ) && return false

    has_collision = cur_grid.table[cur_row, cur_col]
    has_collision && return false
  end

  true
end
