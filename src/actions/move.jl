function move!(cur_player::AbstractPlayer, with_shadow::Bool=true)

  # ==================
  #  handle repl move
  # ==================

  if is_repl
    _move_repl(cur_player)

    cur_player.clock.lock =
      Nullable{Base.Random.UUID}()

    return
  end

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
  #  update score
  # ==============

  cur_js *= """
    \$(".js-score-text").text("$(lpad(cur_player.score, 8, "0"))");
  """

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
      \$(".cs-main-area .cs-row-$(cur_row) td:nth-child($(cur_col)).js-shadow-piece").removeClass();

      cur_cell = \$(".cs-main-area .cs-row-$(cur_row) td:nth-child($(cur_col)):not(.cs-color)");

      cur_cell.addClass("js-active-piece cs-color");
      cur_cell.addClass("cs-$(cur_piece.color)");
    """
  end

  # ==============
  #  return early
  #  if no shadow
  # ==============

  if is_ide && !with_shadow
    tetris_js(cur_player.game.scope, JSString(cur_js))

    cur_player.clock.lock =
      Nullable{Base.Random.UUID}()

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
      cur_cell = \$(".cs-main-area .cs-row-$(cur_row) td:nth-child($(cur_col)):not(.cs-color)");

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
      cur_cell = \$(".cs-main-area .cs-row-$(cur_row) td:nth-child($(cur_col)).js-shadow-piece");
    """

    cur_dict = Dict(
      "top" => (cur_row+1, cur_col),
      "bottom" => (cur_row-1, cur_col),
      "left" => (cur_row, cur_col-1),
      "right" => (cur_row, cur_col+1),
    )

    for (cur_direction, (other_row, other_col)) in cur_dict
      cur_js *= """
        other_cell = \$(".cs-main-area .cs-row-$(other_row) td:nth-child($(other_col)).cs-color:not(.js-shadow-piece)");

        if ( other_cell.length > 0 ) {
          cur_cell.addClass("cs-no-$(cur_direction)-border");
        }
      """
    end
  end

  # ==============
  #  wrap up move
  # ==============

  tetris_js(cur_player.game.scope, JSString(cur_js))

  cur_player.clock.lock =
    Nullable{Base.Random.UUID}()

  return

end

function _move_repl(cur_player::AbstractPlayer)
  cur_string = []

  cur_piece = cur_player.piece

  cur_piece_coords = map(
    cur_block -> calc_block_coords(cur_block),
    cur_piece.blocks
  )

  row_info = map(first, cur_piece_coords)
  col_info = map(last, cur_piece_coords)

  max_row = min(cur_player.grid.rows, maximum(row_info) + cur_player.piece.width )

  min_col = max(1, minimum(col_info) - cur_player.piece.width )
  max_col = min(cur_player.grid.cols, maximum(col_info) + cur_player.piece.width )

  cur_shadow = cur_player.shadow

  cur_shadow_coords = map(
    cur_block -> calc_block_coords(cur_block),
    cur_shadow.blocks
  )

  for cur_row in 1:max_row
    for cur_col in 1:cur_player.grid.cols
      has_piece = cur_player.grid.table[cur_row, cur_col] != ""
      has_piece && continue

      if in((cur_row, cur_col), cur_piece_coords)
        cur_color = cur_piece.color
      elseif in((cur_row, cur_col), cur_shadow_coords)
        cur_color = "$(cur_piece.color)_shadow"
      else
        cur_color = "invisible"
      end

      push!(cur_string, "\x1b[$(cur_player.grid.rows-cur_row+4);$(29+2*cur_col)H")
      push!(cur_string, crayon_dict[cur_color])
      push!(cur_string, "  ")
      push!(cur_string, inv(crayon_dict[cur_color]))
    end
  end

  push!(cur_string, "\x1b[u")
  print(cur_string...)
end
