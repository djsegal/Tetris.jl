function move!(cur_piece::AbstractPiece, is_main_piece::Bool=true)
  cur_class = is_main_piece ?
    "js-active-piece" : "js-shadow-piece"

  cur_js = """
    \$(".$(cur_class)").removeClass();

    var cur_cell;
  """

  cur_coords = map(
    cur_block -> calc_block_coords(cur_block),
    cur_piece.blocks
  )

  for (cur_row, cur_col) in cur_coords
    cur_js *= """
      cur_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col))");
      cur_cell.addClass("cs-$(cur_piece.color)");
      cur_cell.addClass("$(cur_class)");
    """
  end

  cur_player = cur_piece.owner

  evaljs(cur_player.game.scope, JSString(cur_js))

  is_main_piece &&
    ( cur_player.clock.last_move = now() )

  return

end
