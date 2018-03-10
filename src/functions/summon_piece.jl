function summon_piece!(cur_player::AbstractPlayer)

  cur_bag = cur_player.bag
  cur_previews = cur_bag.previews

  is_first_piece = isempty(cur_bag.pieces)

  target_pieces = 2 * cur_previews + 1

  is_first_piece && ( target_pieces += cur_previews )

  while length(cur_bag.pieces) < target_pieces
    fill_bag!(cur_bag)
  end

  if is_first_piece
    bad_blocks = ['s', 'z', 'o']

    while first(cur_bag.pieces).name in bad_blocks
      shift!(cur_bag.pieces)
    end
  end

  cur_piece = shift!(cur_player.bag.pieces)

  cur_player.piece = cur_piece
  cur_piece.owner = cur_player

  pin_piece!(cur_piece)

  reset_shadow!(cur_player)

  check(cur_piece, cur_player.grid) ||
    return false

  move!(cur_player)

  cur_game = cur_player.game

  cur_js = """
    \$(".js-preview-piece td").removeClass();
    var tmp_cell;
  """

  for (cur_index, cur_piece) in enumerate(cur_player.bag.pieces[1:cur_previews])
    for cur_block in cur_piece.blocks
      (cur_row, cur_col) = calc_block_coords(cur_block)

      cur_row += 2
      cur_col += 3

      ( cur_piece.name == 'i' ) && ( cur_row -= 1 )

      cur_js *= """
        tmp_cell = \$(".js-preview-piece__$(cur_index) .cs-row-$(cur_row) td:nth-child($(cur_col))");
        tmp_cell.addClass("cs-color cs-$(cur_piece.color)");
      """
    end
  end

  evaljs(
    cur_game.scope,
    JSString(cur_js)
  )

  true
end
