mutable struct Block <: AbstractBlock
  piece::Piece{Vector{Block}}
  # no children

  x::Integer
  y::Integer
end
