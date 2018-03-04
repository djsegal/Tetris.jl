function move!(cur_player::AbstractPlayer, with_shadow::Bool=true)

  # ====================
  #  start from scratch
  # ====================

  cur_js = """
    \$(".js-active-piece").removeClass();
  """

  if with_shadow
    cur_js *= """
      \$(".js-shadow-piece").removeClass();
    """
  end

  # ==============
  #  re-add piece
  # ==============

  cur_piece = cur_player.piece

  cur_coords = map(
    cur_block -> calc_block_coords(cur_block),
    cur_piece.blocks
  )

  cur_js *= """
    var cur_cell;
  """

  for (cur_row, cur_col) in cur_coords
    cur_js *= """
      \$(".cs-row-$(cur_row) td:nth-child($(cur_col)).js-shadow-piece").removeClass();

      cur_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col)):not(.cs-color)");

      cur_cell.addClass("js-active-piece cs-color");
      cur_cell.addClass("cs-$(cur_piece.color)");
    """
  end

  # ==============
  #  return early
  #  if no shadow
  # ==============

  if !with_shadow
    evaljs(cur_player.game.scope, JSString(cur_js))
    cur_player.clock.last_move = now()

    return
  end

  # ============
  #  add shadow
  # ============

  cur_shadow = cur_player.shadow

  cur_coords = map(
    cur_block -> calc_block_coords(cur_block),
    cur_shadow.blocks
  )

  for (cur_row, cur_col) in cur_coords
    cur_js *= """
      cur_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col)):not(.cs-color)");

      cur_cell.addClass("js-shadow-piece cs-color");
      cur_cell.addClass("cs-$(cur_shadow.color)");
    """
  end

  # ====================
  #  remove bad borders
  # ====================

  cur_js *= """
    var other_cell;
  """

  for (cur_row, cur_col) in cur_coords
    cur_js *= """
      cur_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col)).js-shadow-piece");
    """

    cur_dict = Dict(
      "top" => (cur_row+1, cur_col),
      "bottom" => (cur_row-1, cur_col),
      "left" => (cur_row, cur_col-1),
      "right" => (cur_row, cur_col+1),
    )

    for (cur_direction, (other_row, other_col)) in cur_dict
      cur_js *= """
        other_cell = \$(".cs-row-$(other_row) td:nth-child($(other_col)).cs-color:not(.js-shadow-piece)");

        if ( other_cell.length > 0 ) {
          cur_cell.addClass("cs-no-$(cur_direction)-border");
        }
      """
    end
  end

  # ==============
  #  wrap up move
  # ==============

  evaljs(cur_player.game.scope, JSString(cur_js))
  cur_player.clock.last_move = now()

  return

end
