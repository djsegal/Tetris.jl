function move!(cur_player::AbstractPlayer)

  cur_html = """
    <script class="cs-step-script">
      \$(".cs-step-script").parent().css("padding", 0)
      var cur_cell;
      var all_good = true;
  """

  cur_piece = cur_player.piece

  old_plot = cur_player.state.last_plot

  new_plot = map(
    cur_block -> calc_block_coords(cur_block),
    cur_piece.blocks
  )

  for (cur_row, cur_col) in old_plot
    cur_html *= """
      cur_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col))");
      all_good = ( all_good && cur_cell.hasClass("cs-$(cur_piece.color)") );
    """
  end

  cur_html *= """
    if ( all_good ) {
  """

  cur_plot_functions = OrderedDict(
    "removeClass" => old_plot,
    "addClass" => new_plot
  )

  for (cur_function, cur_plot) in cur_plot_functions

    for (cur_row, cur_col) in cur_plot
      cur_html *= """
        cur_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col))");
        cur_cell.$(cur_function)("cs-$(cur_piece.color)");
      """
    end

  end

  cur_html *= """
    }
  """

  cur_html *= "</script>"

  display(HTML(cur_html))

  cur_player.state.last_plot = new_plot

  cur_player.clock.last_move = now()

  return

end
