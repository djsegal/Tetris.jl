function end_round(cur_player::AbstractPlayer, is_restart::Bool=false)
  cur_player.state.is_playing = false
  cur_player.state.is_done = true

  set_default_values(cur_player)

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
