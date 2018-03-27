mutable struct Clock <: AbstractClock
  player::AbstractPlayer

  last_move::Union{DateTime, Nullable{DateTime}}

  drop::Union{Base.Random.UUID, Nullable{Base.Random.UUID}}
  lock::Union{Base.Random.UUID, Nullable{Base.Random.UUID}}
  hold::Union{Base.Random.UUID, Nullable{Base.Random.UUID}}
  drag::Union{Base.Random.UUID, Nullable{Base.Random.UUID}}

  push::Union{Base.Random.UUID, Nullable{Base.Random.UUID}}
end

function Clock(cur_player::AbstractPlayer=Player())
  cur_clock = Clock(
    cur_player,
    Nullable{DateTime}(),
    Nullable{Base.Random.UUID}(),
    Nullable{Base.Random.UUID}(),
    Nullable{Base.Random.UUID}(),
    Nullable{Base.Random.UUID}(),
    Nullable{Base.Random.UUID}()
  )

  cur_player.clock = cur_clock

  cur_clock
end
