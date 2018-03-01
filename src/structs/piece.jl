mutable struct Piece{T <: Vector{<:AbstractBlock}} <: AbstractPiece
  owner::Union{AbstractContainer, Nullable{AbstractContainer}}
  blocks::T

  name::Char
  color::AbstractString
  width::Integer

  i::Integer
  j::Integer
end
