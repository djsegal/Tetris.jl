function check_clock(cur_player::AbstractPlayer, cur_clock_symbol::Union{Void, Symbol}=nothing, expected_uuid::Union{Void, Base.Random.UUID}=nothing)
  cur_state = cur_player.state

  cur_state.is_playing || return false

  cur_state.is_done && return false

  ( cur_clock_symbol == nothing ) && return true

  actual_uuid = getfield(cur_player.clock, cur_clock_symbol)

  actual_uuid == expected_uuid
end
