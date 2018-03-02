function move!(cur_player::AbstractPlayer)

  cur_js = """
    \$(".js-active-piece").removeClass();

    var cur_cell;
  """

  cur_piece = cur_player.piece

  cur_coords = map(
    cur_block -> calc_block_coords(cur_block),
    cur_piece.blocks
  )

  for (cur_row, cur_col) in cur_coords
    cur_js *= """
      cur_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col))");
      cur_cell.addClass("cs-$(cur_piece.color) js-active-piece");
    """
  end

  evaljs(cur_player.game.scope, JSString(cur_js))

  cur_player.clock.last_move = now()

  return

end
