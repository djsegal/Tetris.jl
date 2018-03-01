mutable struct State <: AbstractState
  player::AbstractPlayer

  is_playing::Bool
  has_lost::Bool

  last_plot::Vector{Tuple{Int,Int}}
end

function State(cur_player::AbstractPlayer=Player())
  cur_is_playing = true
  cur_has_lost = false

  cur_state = State(
    cur_player,
    cur_is_playing,
    cur_has_lost,
    []
  )

  cur_player.state = cur_state

  cur_state
end
