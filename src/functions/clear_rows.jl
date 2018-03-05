function clear_rows!(cur_player::AbstractPlayer, cleared_rows::Vector{Int})
  cur_grid = cur_player.grid

  cur_js = """
    var beg_row, end_row, work_row;
  """

  for (cur_index, cur_row) in enumerate(cleared_rows)
    next_row =
      ( cur_index == length(cleared_rows) ) ?
      ( cur_grid.height + 1 ) :
      cleared_rows[cur_index+1]

    cur_range = cur_row+1:next_row-1

    cur_grid.table[cur_range-cur_index,:] =
      cur_grid.table[cur_range,:]

    cur_js *= """
      \$(".cs-main-area .cs-row-$(cur_row)").empty();
    """

    for tmp_row in cur_range
      cur_js *= """
        beg_row = "cs-main-area .cs-row-$(tmp_row)";
        end_row = "cs-main-area .cs-row-$(tmp_row-cur_index)";

        \$("." + beg_row).children().appendTo("." + end_row);
        \$("." + beg_row).empty();
      """
    end
  end

  end_index = cur_grid.height
  row_count = length(cleared_rows)

  cur_grid.height -= row_count
  cur_player.lines += row_count

  cur_range = -(row_count-1):0
  cur_range += end_index

  cur_grid.table[cur_range, :] = ""

  cur_string = "<td></td>" ^ cur_grid.cols

  for tmp_row in cur_range
    cur_js *= """
      work_row = "cs-main-area .cs-row-$(tmp_row)";

      \$("$(cur_string)").appendTo("." + work_row);
    """
  end

  cur_js
end
