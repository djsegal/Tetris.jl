mutable struct Game{T <: Vector{<:AbstractPlayer}} <: AbstractGame
  # no parent
  scope::Scope
  players::T
  in_focus::Bool
  board::Board
end

function Game(cur_scope::Scope=Scope())
  cur_game = Game(
    cur_scope,
    AbstractPlayer[],
    false,
    Board()
  )

  cur_game
end
