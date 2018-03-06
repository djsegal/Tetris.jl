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
  else
    cleared_count = length(cleared_rows)

    @assert 0 < cleared_count < 5

    if cur_player.combo > 0
      cur_score = ( cleared_count == 1 ) ? 20 : 50

      cur_score *= cur_player.combo * cur_player.level

      cur_player.score += cur_score
    end

    cur_player.combo += 1

    score_array = [ 100, 300, 500, 800 ]

    cur_player.score += score_array[cleared_count]

    cur_js *= """
      \$(".js-score-text").text("$(lpad(cur_player.score, 8, "0"))");
    """

    cur_js *= clear_rows!(cur_player, cleared_rows)
  end

  evaljs(cur_player.game.scope, JSString(cur_js))

  cur_piece.owner = Nullable{AbstractContainer}()
  cur_player.piece = Nullable{AbstractPiece}()

  cur_player.state.can_hold |= true
end
