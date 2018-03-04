function glue_piece!(cur_player::AbstractPlayer)
  cur_js = """
    \$(".js-shadow-piece, .js-active-piece").removeClass();

    var tmp_cell;
  """

  cur_piece = cur_player.piece

  cur_grid = cur_player.grid

  cur_rows = SortedSet()

  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)

    cur_js *= """
      tmp_cell = \$(".cs-row-$(cur_row) td:nth-child($(cur_col))");

      tmp_cell.addClass("cs-color cs-$(cur_piece.color)");
    """

    ( cur_grid.height < cur_row ) &&
      ( cur_grid.height = cur_row )

    push!(cur_rows, cur_row)
    cur_player.grid.table[cur_row, cur_col] = cur_piece.color
  end

  cleared_rows = Int[]

  for cur_row in cur_rows
    any(
      cur_cell -> ( cur_cell == "" ),
      cur_player.grid.table[cur_row, :]
    ) && continue

    push!(cleared_rows, cur_row)
  end

  isempty(cleared_rows) ||
    ( cur_js *= clear_rows!(cur_player, cleared_rows) )

  evaljs(cur_player.game.scope, JSString(cur_js))

  cur_piece.owner = Nullable{AbstractContainer}()
  cur_player.piece = Nullable{AbstractPiece}()
end
