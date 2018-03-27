function reset_shadow!(cur_player::AbstractPlayer)
  cur_piece = cur_player.piece
  cur_shadow = cur_player.shadow

  cur_shadow.color = cur_piece.color
  cur_shadow.width = cur_piece.width

  cur_shadow.i = cur_piece.i
  cur_shadow.j = cur_piece.j

  for (piece_block, shadow_block) in zip(cur_piece.blocks, cur_shadow.blocks)
    shadow_block.x = piece_block.x
    shadow_block.y = piece_block.y
  end

  hard_drop(cur_player, cur_shadow)
end
