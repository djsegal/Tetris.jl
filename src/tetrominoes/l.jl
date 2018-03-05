function l_piece(cur_container::AbstractContainer)
  cur_piece = Piece(
    cur_container,
    Block[],
    'l',
    "orange",
    3,
    0,
    -1,
    -1
  )

  cur_block_coords = [
    (+1, +1),
    (-1, 0),
    (0, 0),
    (+1, 0)
  ]

  make_blocks!(cur_piece, cur_block_coords)

  cur_piece
end
