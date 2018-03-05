function i_piece(cur_container::AbstractContainer)
  cur_piece = Piece(
    cur_container,
    Block[],
    'i',
    "cyan",
    4,
    0,
    -1,
    -1
  )

  cur_block_coords = [
    (-2, +1),
    (-1, +1),
    (+1, +1),
    (+2, +1)
  ]

  make_blocks!(cur_piece, cur_block_coords)

  cur_piece
end
