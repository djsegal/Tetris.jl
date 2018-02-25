mutable struct Game{T <: Vector{<:AbstractPlayer}} <: AbstractGame
  # no parent
  players::T
end

mutable struct Player <: AbstractPlayer
  game::Game{Vector{Player}}
  grid::Union{AbstractGrid, Nullable{AbstractGrid}}
end

mutable struct Grid{T <: Vector{<:AbstractPiece}} <: AbstractGrid
  player::Player
  pieces::T
end

mutable struct Piece{T <: Vector{<:AbstractBlock}} <: AbstractPiece
  grid::Grid{Vector{Piece}}
  blocks::T
end

mutable struct Block <: AbstractBlock
  piece::Piece{Vector{Block}}
end
