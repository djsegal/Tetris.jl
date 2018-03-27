function set_default_values(cur_player::AbstractPlayer)

  cur_player.grid.height = 0
  fill!(cur_player.grid.table, "")

  empty!(cur_player.bag.pieces)

  if cur_player.round.is_keeping_score
    Round(cur_player)
  end

  cur_player.hold = Nullable{AbstractPiece}()
  cur_player.piece = Nullable{AbstractPiece}()
  cur_player.shadow = Piece(cur_player)

  cur_player.level = 1
  cur_player.score = 0

  cur_player.lines = 0
  cur_player.combo = 0

  cur_player.glues = 0

end
