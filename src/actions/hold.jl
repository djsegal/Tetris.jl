function hold(cur_player::AbstractPlayer)
  cur_player.state.can_hold || return
  cur_player.state.can_hold = false

  work_piece, cur_player.piece =
    cur_player.piece, cur_player.hold

  work_piece.owner = Nullable{AbstractContainer}()

  make_piece!(
    cur_player,
    work_piece.name,
    :hold
  )

  isnull(cur_player.piece) && return
  pin_piece!(cur_player.piece)

  reset_shadow!(cur_player)
  move!(cur_player)
end
