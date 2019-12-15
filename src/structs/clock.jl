mutable struct Clock <: AbstractClock
  player::AbstractPlayer

  last_move::Union{DateTime, Nullable{DateTime}}

  drop::Union{UUIDs.UUID, Nullable{UUIDs.UUID}}
  lock::Union{UUIDs.UUID, Nullable{UUIDs.UUID}}
  hold::Union{UUIDs.UUID, Nullable{UUIDs.UUID}}
  drag::Union{UUIDs.UUID, Nullable{UUIDs.UUID}}

  push::Union{UUIDs.UUID, Nullable{UUIDs.UUID}}
end

function Clock(cur_player::AbstractPlayer=Player())
  cur_clock = Clock(
    cur_player,
    Nullable{DateTime}(),
    Nullable{UUIDs.UUID}(),
    Nullable{UUIDs.UUID}(),
    Nullable{UUIDs.UUID}(),
    Nullable{UUIDs.UUID}(),
    Nullable{UUIDs.UUID}()
  )

  cur_player.clock = cur_clock

  cur_clock
end
