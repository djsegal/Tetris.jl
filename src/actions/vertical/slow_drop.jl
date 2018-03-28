function soft_drop(cur_player::AbstractPlayer, is_step::Bool=false)
  cur_piece = cur_player.piece
  cur_grid = cur_player.grid

  did_move = drop!(
    cur_player, cur_piece, cur_grid,
    -1, true, is_step
  )

  did_move
end
