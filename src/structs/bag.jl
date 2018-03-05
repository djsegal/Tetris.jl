mutable struct Bag{T <: Vector{<:AbstractPiece}} <: AbstractBag
  player::AbstractPlayer
  pieces::T
  previews::Int
end

function Bag(cur_player::AbstractPlayer=Player())
  cur_bag = Bag(
    cur_player,
    AbstractPiece[],
    3
  )

  cur_player.bag = cur_bag

  cur_bag
end
