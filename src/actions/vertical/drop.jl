function drop!(cur_player::AbstractPlayer, cur_piece::AbstractPiece, cur_grid::AbstractGrid, cur_direction::Integer, is_main_piece::Bool)
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

  is_main_piece && move!(cur_player, false)

  true
end

function drop!(cur_player::AbstractPlayer, cur_piece::Nullable{AbstractPiece}, cur_grid::AbstractGrid, cur_direction::Integer, is_main_piece::Bool)
  false
end
