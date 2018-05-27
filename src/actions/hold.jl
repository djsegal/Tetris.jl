function hold(cur_player::AbstractPlayer)

  can_move(cur_player) || return

  cur_player.state.can_hold || return
  cur_player.state.can_hold = false

  score!(cur_player, "hold", -1)

  work_piece, cur_player.piece =
    cur_player.piece, cur_player.hold

  work_piece.owner = Nullable{AbstractContainer}()

  make_piece!(
    cur_player,
    work_piece.name,
    :hold
  )

  cur_js = """
    \$(".js-hold-piece td").removeClass();
    var tmp_cell;
  """

  cur_game = cur_player.game
  cur_piece = cur_player.hold

  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)

    cur_row += 2
    cur_col += 3

    ( cur_piece.name == 'i' ) && ( cur_row -= 1 )

    cur_js *= """
      tmp_cell = \$(".js-hold-piece .cs-row-$(cur_row) td:nth-child($(cur_col))");
      tmp_cell.addClass("cs-color cs-$(cur_piece.color)");
    """
  end

  tetris_js(
    cur_game.scope,
    JSString(cur_js)
  )

  isnull(cur_player.piece) && return
  pin_piece!(cur_player.piece)

  reset_shadow!(cur_player)
  move!(cur_player)

  step(cur_player)

  return

end
