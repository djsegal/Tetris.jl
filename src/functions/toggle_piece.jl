function toggle_piece(cur_piece::AbstractPiece, is_shown::Bool=true)
  cur_html = """
    <script class="cs-step-script">
      \$(".cs-step-script").parent().css("padding", 0)
      var cur_cell;
  """

  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)

    cur_function = is_shown ? "addClass" : "removeClass"

    cur_html *= """
      cur_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col))");
      cur_cell.$(cur_function)("cs-$(cur_piece.color)");
    """
  end

  cur_html *= "</script>"

  display(HTML(cur_html))
end
