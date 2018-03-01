mutable struct Game{T <: Vector{<:AbstractPlayer}} <: AbstractGame
  # no parent
  players::T
  in_focus::Bool
end

function Game()
  cur_game = Game(AbstractPlayer[], false)

  cur_game
end
