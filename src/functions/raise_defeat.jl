function raise_defeat(cur_player::AbstractPlayer, is_restart::Bool=false)
  cur_player.state.is_playing = false
  cur_player.state.has_lost = true

  cur_player.grid.height = 0
  fill!(cur_player.grid.table, "")

  empty!(cur_player.bag.pieces)

  cur_player.hold = Nullable{AbstractPiece}()
  cur_player.piece = Nullable{AbstractPiece}()
  cur_player.shadow = Piece(cur_player)

  Round(cur_player)

  cur_player.level = 1
  cur_player.score = 0

  cur_player.lines = 0
  cur_player.combo = 0

  cur_player.glues = 0

  cur_js = """
    \$(".js-tetris-container").blur();
  """

  if is_restart
    cur_js *= """
      \$(".js-tetris-container td").removeClass();
      \$(".js-level-text").text("Level 1");
      \$(".js-score-text").text("$(lpad(0, 8, "0"))");
    """
  else
    cur_js *= """
      \$(".js-splash-text h1").text("game over.")
      \$(".js-splash-text div").text("try again soon.")
    """
  end

  evaljs(
    cur_player.game.scope,
    JSString(cur_js)
  )

  false
end
