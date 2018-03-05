mutable struct Piece{T <: Vector{<:AbstractBlock}} <: AbstractPiece
  owner::Union{AbstractContainer, Nullable{AbstractContainer}}
  blocks::T

  name::Char
  color::AbstractString

  width::Integer
  rotation::Integer

  i::Integer
  j::Integer
end

function Piece(cur_owner::AbstractContainer)
  cur_piece =
    Piece(
      cur_owner,
      Block[],
      'x',
      "grey",
      -1,
      -1,
      -1,
      -1
    )

  for cur_count in 1:4
    push!(
      cur_piece.blocks,
      Block(cur_piece, -1, -1)
    )
  end

  cur_piece
end
