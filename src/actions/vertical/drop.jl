function drop!(cur_player::AbstractPlayer, cur_piece::AbstractPiece, cur_grid::AbstractGrid, cur_direction::Integer, is_main_piece::Bool, is_step::Bool)
  can_move(cur_player) || return false

  cur_blocks = map(
    cur_block -> calc_block_coords(cur_block),
    cur_piece.blocks
  )

  did_move = false

  new_direction = 0

  for tmp_direction in sign(cur_direction):sign(cur_direction):cur_direction

    for (cur_index, cur_block) in enumerate(cur_blocks)
      cur_blocks[cur_index] = (
        first(cur_block) + sign(cur_direction),
        last(cur_block) + 0
      )
    end

    check(cur_blocks, cur_grid) || break

    did_move = true

    new_direction = tmp_direction

  end

  did_move || return false

  cur_piece.i += new_direction

  if is_main_piece && !is_step
    drop_count = abs(new_direction)

    if drop_count == 1
      score!(cur_player, "soft", -1)
    else
      score!(cur_player, "hard", drop_count)
    end
  end

  if is_main_piece
    move!(cur_player, false)

    cur_player.clock.drag =
      Nullable{Base.Random.UUID}()
  end

  true
end

function drop!(cur_player::AbstractPlayer, cur_piece::Nullable{AbstractPiece}, cur_grid::AbstractGrid, cur_direction::Integer, is_main_piece::Bool, is_step::Bool)
  false
end
