mutable struct Game{T <: Vector{<:AbstractPlayer}} <: AbstractGame
  # no parent
  players::T
end

mutable struct Player <: AbstractPlayer
  game::Game{Vector{Player}}
  grid::Union{AbstractGrid, Nullable{AbstractGrid}}

  bag::Union{AbstractBag, Nullable{AbstractBag}}
  piece::Union{AbstractPiece, Nullable{AbstractPiece}}

  is_playing::Bool
end

mutable struct Grid{T <: Vector{<:AbstractPiece}} <: AbstractGrid
  player::Player
  pieces::T

  rows::Integer
  cols::Integer

  hidden_rows::Integer

  table::Array{Bool,2}
end

mutable struct Bag{T <: Vector{<:AbstractPiece}} <: AbstractBag
  player::Player
  pieces::T
end

mutable struct Piece{T <: Vector{<:AbstractBlock}} <: AbstractPiece
  owner::Union{AbstractContainer, Nullable{AbstractContainer}}
  blocks::T

  name::Char
  color::AbstractString
  width::Integer

  i::Integer
  j::Integer
end

mutable struct Block <: AbstractBlock
  piece::Piece{Vector{Block}}
  # no children

  x::Integer
  y::Integer
end
