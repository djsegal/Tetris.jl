function glue_piece!(cur_player::AbstractPlayer)
  cur_piece = cur_player.piece

  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)
    cur_player.grid.table[cur_row, cur_col] = cur_piece.color
  end

  cur_player.state.last_plot = []

  cur_piece.owner = Nullable{AbstractContainer}()
  cur_player.piece = Nullable{AbstractPiece}()
end
