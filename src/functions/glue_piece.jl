function glue_piece!(cur_player::AbstractPlayer)
  cur_html = """
    <script class="cs-step-script">
      \$(".cs-step-script").parent().css("padding", 0);

      \$(".js-active-piece").removeClass("js-active-piece");
    </script>
  """

  display(HTML(cur_html))

  cur_piece = cur_player.piece

  for cur_block in cur_piece.blocks
    (cur_row, cur_col) = calc_block_coords(cur_block)
    cur_player.grid.table[cur_row, cur_col] = cur_piece.color
  end

  cur_piece.owner = Nullable{AbstractContainer}()
  cur_player.piece = Nullable{AbstractPiece}()
end
