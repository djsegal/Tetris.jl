mutable struct Observer <: AbstractObserver
  player::AbstractPlayer

  action::Union{Observable, Nullable{Observable}}
end

function Observer(cur_player::AbstractPlayer=Player())
  cur_observer = Observer(
    cur_player,
    Nullable{Observable}()
  )

  cur_player.observer = cur_observer

  cur_observer
end
