mutable struct Game{T <: Vector{<:AbstractPlayer}} <: AbstractGame
  # no parent
  scope::Scope
  players::T
  in_focus::Bool
end

function Game(cur_scope::Scope=Scope())
  cur_game = Game(
    cur_scope,
    AbstractPlayer[],
    false
  )

  cur_game
end
