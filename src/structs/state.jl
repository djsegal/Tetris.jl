mutable struct State <: AbstractState
  player::AbstractPlayer

  is_playing::Bool
  has_lost::Bool

  can_hold::Bool
end

function State(cur_player::AbstractPlayer=Player())
  cur_is_playing = true
  cur_has_lost = false
  can_hold = true

  cur_state = State(
    cur_player,
    cur_is_playing,
    cur_has_lost,
    can_hold
  )

  cur_player.state = cur_state

  cur_state
end
