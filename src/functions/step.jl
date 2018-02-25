function step(cur_player::AbstractPlayer)
  isnull(cur_player.piece) && summon_piece!(cur_player)

  cur_piece = cur_player.piece

  toggle_piece(cur_piece, false)

  if check_drop(cur_piece)
    soft_drop!(cur_piece)
    toggle_piece(cur_piece, true)
  else
    toggle_piece(cur_piece, true)
    glue_piece!(cur_piece)

    check_defeat(cur_player, cur_piece) &&
      raise_defeat(cur_player)
  end
end
