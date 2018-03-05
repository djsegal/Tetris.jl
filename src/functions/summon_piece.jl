function summon_piece!(cur_player::AbstractPlayer)

  cur_bag = cur_player.bag
  cur_previews = cur_bag.previews

  while length(cur_bag.pieces) < ( 2 * cur_previews + 1 )
    fill_bag!(cur_bag)
  end

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
