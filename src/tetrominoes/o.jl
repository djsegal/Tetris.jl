function o_piece(cur_container::AbstractContainer)
  cur_piece = Piece(
    cur_container,
    Block[],
    'o',
    "yellow",
    2,
    0,
    -1,
    -1
  )

  cur_block_coords = [
    (-1, +1),
    (-1, -1),
    (+1, -1),
    (+1, +1)
  ]

  make_blocks!(cur_piece, cur_block_coords)

  cur_piece
end
