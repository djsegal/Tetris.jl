mutable struct Player <: AbstractPlayer
  game::Game{Vector{AbstractPlayer}}
  grid::Union{AbstractGrid, Nullable{AbstractGrid}}

  bag::Union{AbstractBag, Nullable{AbstractBag}}
  piece::Union{AbstractPiece, Nullable{AbstractPiece}}

  observer::Union{AbstractObserver, Nullable{AbstractObserver}}
  state::Union{AbstractState, Nullable{AbstractState}}
  clock::Union{AbstractClock, Nullable{AbstractClock}}

  action::AbstractString
end

function Player(cur_game::AbstractGame=Game())
  cur_player = Player(
    cur_game,
    Nullable{AbstractGrid}(),
    Nullable{AbstractBag}(),
    Nullable{AbstractPiece}(),
    Nullable{AbstractObserver}(),
    Nullable{AbstractState}(),
    Nullable{AbstractClock}(),
    ""
  )

  push!(cur_game.players, cur_player)

  Observer(cur_player)
  State(cur_player)
  Clock(cur_player)

  Grid(cur_player)
  Bag(cur_player)

  cur_player
end
