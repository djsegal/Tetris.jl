function rotate!(cur_player::AbstractPlayer, cur_piece::AbstractPiece, cur_grid::AbstractGrid, cur_direction::Integer)

  cur_blocks = map(
    cur_block -> calc_block_coords(cur_block, cur_direction),
    cur_piece.blocks
  )

  check(cur_blocks, cur_grid) || return false

  for cur_block in cur_piece.blocks
    cur_block.x, cur_block.y =
      cur_block.y, cur_block.x

    cur_block.y *= -sign(cur_direction)
    cur_block.x *= +sign(cur_direction)
  end

  move!(cur_player)

  true
end
