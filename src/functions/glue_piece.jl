function glue_piece!(cur_player::AbstractPlayer)
  cur_piece = cur_player.piece

  isnull(cur_piece) && return

  score!(cur_player, "glue", -1)

  cur_player.glues += 1

  cur_player.state.can_hold |= true

  cur_js = """
    \$(".js-shadow-piece, .js-active-piece").removeClass();

    var tmp_cell;
  """

  cur_grid = cur_player.grid

  cur_rows = SortedSet()

  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)

    cur_js *= """
      tmp_cell = \$(".cs-main-area .cs-row-$(cur_row) td:nth-child($(cur_col))");

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

  if isempty(cleared_rows)
    cur_player.combo = 0

    is_valid = false

    for cur_block in cur_piece.blocks
      (cur_row, cur_col) = calc_block_coords(cur_block)
      ( cur_row > cur_grid.rows ) && continue

      is_valid = true
      break
    end

    is_valid || return raise_defeat(cur_player)
  else
    cleared_count = length(cleared_rows)

    @assert 0 < cleared_count < 5

    ( cur_player.combo > 0 ) &&
      score!(cur_player, "combo", cleared_count)

    score!(cur_player, "clear", cleared_count)

    cur_player.combo += 1

    cur_js *= """
      \$(".js-score-text").text("$(lpad(cur_player.score, 8, "0"))");
    """

    cur_js *= clear_rows!(cur_player, cleared_rows)
  end

  evaljs(cur_player.game.scope, JSString(cur_js))

  cur_piece.owner = Nullable{AbstractContainer}()
  cur_player.piece = Nullable{AbstractPiece}()

  drop_clock(cur_player)
end
