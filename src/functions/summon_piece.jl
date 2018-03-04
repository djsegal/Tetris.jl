function summon_piece!(cur_player::AbstractPlayer)
  isempty(cur_player.bag.pieces) && fill_bag!(cur_player.bag)

  cur_piece = shift!(cur_player.bag.pieces)

  cur_player.piece = cur_piece
  cur_piece.owner = cur_player

  pin_piece!(cur_piece)

  reset_shadow!(cur_player)

  check(cur_piece, cur_player.grid) ||
    return false

  move!(cur_player)

  true
end
