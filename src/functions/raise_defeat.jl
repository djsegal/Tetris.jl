function raise_defeat(cur_player::AbstractPlayer)
  cur_player.state.is_playing = false
  cur_player.state.has_lost = true

  cur_player.grid.height = 0
  fill!(cur_player.grid.table, "")

  empty!(cur_player.bag.pieces)

  cur_player.hold = Nullable{AbstractPiece}()
  cur_player.piece = Nullable{AbstractPiece}()
  cur_player.shadow = Piece(cur_player)

  cur_player.level = 1
  cur_player.score = 0

  cur_player.lines = 0
  cur_player.combo = 0

  evaljs(
    cur_player.game.scope,
    JSString("""
      \$(".js-tetris-container").blur();
      \$(".js-splash-text h1").text("game over.")
      \$(".js-splash-text div").text("try again soon.")
    """)
  )

  false
end
