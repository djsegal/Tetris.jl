function grid_layout(cur_grid::AbstractGrid)
  cur_layout = """<table class="cs-tetris-table z-depth-1">"""

  total_rows = cur_grid.rows + cur_grid.hidden_rows

  for cur_row in total_rows:-1:1
    cur_class = "cs-row-$(cur_row)"

    ( cur_row > cur_grid.rows ) && ( cur_class *= " hidden" )

    cur_layout *= """<tr class="$(cur_class)">"""

    for cur_col in 1:cur_grid.cols
      cur_layout *= """<td class="cs-light-grey">"""
      cur_layout *= """</td>"""
    end

    cur_layout *= """</tr>"""
  end

  cur_layout *= """</table>"""

  cur_layout
end
