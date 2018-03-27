mutable struct Player <: AbstractPlayer
  game::Game{Vector{AbstractPlayer}}
  grid::Union{AbstractGrid, Nullable{AbstractGrid}}

  bag::Union{AbstractBag, Nullable{AbstractBag}}

  piece::Union{AbstractPiece, Nullable{AbstractPiece}}
  shadow::Union{AbstractPiece, Nullable{AbstractPiece}}
  hold::Union{AbstractPiece, Nullable{AbstractPiece}}

  round::Union{AbstractRound, Nullable{AbstractRound}}
  state::Union{AbstractState, Nullable{AbstractState}}
  clock::Union{AbstractClock, Nullable{AbstractClock}}

  action::AbstractString
  chain::AbstractString

  level::Int
  score::Int

  lines::Int
  combo::Int

  stash::Int
  glues::Int
end

function Player(cur_game::AbstractGame=Game())
  cur_player = Player(
    cur_game,
    Nullable{AbstractGrid}(),
    Nullable{AbstractBag}(),
    Nullable{AbstractPiece}(),
    Nullable{AbstractPiece}(),
    Nullable{AbstractPiece}(),
    Nullable{AbstractRound}(),
    Nullable{AbstractState}(),
    Nullable{AbstractClock}(),
    "",
    "",
    1,
    0,
    0,
    0,
    0,
    0
  )

  push!(cur_game.players, cur_player)

  State(cur_player)
  Clock(cur_player)

  Grid(cur_player)
  Bag(cur_player)

  cur_player.shadow = Piece(cur_player)

  cur_player
end
