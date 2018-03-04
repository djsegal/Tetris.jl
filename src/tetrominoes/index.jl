const tetrominoes = [
  'i', 'j', 'l', 'o',
  's', 't', 'z'
]

for cur_tetromino in tetrominoes
  include("$(cur_tetromino).jl")
end

function make_piece!(cur_container::AbstractContainer, piece_char::Char, cur_association::Symbol=:pieces)
  piece_func = getfield(
    Tetris,
    Symbol("$(piece_char)_piece")
  )

  cur_piece = piece_func(cur_container)

  if cur_association == :pieces
    push!(cur_container.pieces, cur_piece)
  else
    setfield!(cur_container, cur_association, cur_piece)
  end

  true
end

function make_blocks!(cur_piece::AbstractPiece, block_coords::Vector{Tuple{Int64,Int64}})
  for cur_coords in block_coords
    push!(
      cur_piece.blocks,
      Block(cur_piece, cur_coords...)
    )
  end

  true
end
