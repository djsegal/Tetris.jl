function glue_piece!(cur_piece::AbstractPiece)
  cur_player = cur_piece.owner
  cur_player.piece = Nullable{AbstractPiece}()

  push!(cur_player.grid.pieces, cur_piece)
  cur_piece.owner = cur_player.grid

  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)
    cur_player.grid.table[cur_row, cur_col] = true
  end
end
