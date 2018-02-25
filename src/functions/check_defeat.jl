function check_defeat(cur_player::AbstractPlayer, cur_piece::AbstractPiece)
  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)
    ( cur_row > cur_player.grid.rows ) && return true
  end

  false
end
