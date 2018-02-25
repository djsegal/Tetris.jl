function grid_layout()
  cur_grid = """<table class="cs-tetris-table z-depth-1">"""

  for cur_row in 22:-1:1
    cur_class = "cs-row-$(cur_row)"

    ( cur_row > 20 ) && ( cur_class *= " hidden" )

    cur_grid *= """<tr class="$(cur_class)">"""

    for cur_col in 1:10
      cur_grid *= """<td class="cs-light-grey">"""
      cur_grid *= """</td>"""
    end

    cur_grid *= """</tr>"""
  end

  cur_grid *= """</table>"""

  cur_grid
end
