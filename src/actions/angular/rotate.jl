function rotate!(cur_player::AbstractPlayer, cur_piece::AbstractPiece, cur_grid::AbstractGrid, cur_direction::Integer)
  can_move(cur_player) || return false

  ( cur_piece.name == 'o' ) && return false

  initial_rotation = cur_piece.rotation

  cur_piece.rotation += cur_direction

  while cur_piece.rotation <= 0
    cur_piece.rotation += 4
  end

  cur_piece.rotation %= 4

  cur_blocks = map(
    cur_block -> calc_block_coords(cur_block, cur_direction),
    cur_piece.blocks
  )

  is_legal_move = check(cur_blocks, cur_grid)

  cur_x_offset = 0
  cur_y_offset = 0

  if !is_legal_move

    cur_offsets =
      get_rotate_offsets(
        initial_rotation,
        cur_piece.rotation,
        iseven(cur_piece.width)
      )

    for cur_offset in cur_offsets
      is_legal_move = check(
        cur_blocks,
        cur_grid,
        cur_offset
      )

      is_legal_move || continue

      cur_x_offset, cur_y_offset = cur_offset
      break
    end

  end

  is_legal_move || return false

  cur_piece.i += cur_y_offset
  cur_piece.j += cur_x_offset

  for cur_block in cur_piece.blocks
    cur_block.x, cur_block.y =
      ( cur_block.y * +sign(cur_direction) ),
      ( cur_block.x * -sign(cur_direction) )
  end

  reset_shadow!(cur_player)

  move!(cur_player)

  true
end

function rotate!(cur_player::AbstractPlayer, cur_piece::Nullable{AbstractPiece}, cur_grid::AbstractGrid, cur_direction::Integer)
  false
end
