mutable struct State <: AbstractState
  player::AbstractPlayer

  is_playing::Bool
  is_done::Bool

  can_hold::Bool
end

function State(cur_player::AbstractPlayer=Player())
  cur_is_playing = true
  cur_is_done = false
  can_hold = true

  cur_state = State(
    cur_player,
    cur_is_playing,
    cur_is_done,
    can_hold
  )

  cur_player.state = cur_state

  cur_state
end
