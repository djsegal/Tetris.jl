function hard_drop(cur_player::AbstractPlayer)
  cur_piece = cur_player.piece

  isnull(cur_piece) && return false

  did_move = hard_drop(cur_player, cur_piece, true)

  cur_player.clock.lock =
    Nullable{Base.Random.UUID}()

  glue_piece!(cur_player)

  did_move
end

function hard_drop(cur_player::AbstractPlayer, cur_piece::AbstractPiece, is_main_piece::Bool=false)
  cur_grid = cur_player.grid

  max_rows = cur_grid.rows
  max_rows += cur_grid.hidden_rows
  max_rows += 1 # for safe measure

  did_move = drop!(
    cur_player, cur_piece, cur_grid,
    -max_rows, is_main_piece, false
  )

  did_move
end
