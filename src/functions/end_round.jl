function end_round(cur_player::AbstractPlayer, is_restart::Bool=false)
  if is_repl
    println("""



        __ _   __ _  _ __ ___    ___    ___ __   __ ___  _ __
       / _` | / _` || '_ ` _ \\  / _ \\  / _ \\\\ \\ / // _ \\| '__|
      | (_| || (_| || | | | | ||  __/ | (_) |\\ V /|  __/| | _  _  _
       \\__, | \\__,_||_| |_| |_| \\___|  \\___/  \\_/  \\___||_|(_)(_)(_)
        __/ |
       |___/
    """)
  end

  cur_player.state.is_playing = false
  cur_player.state.is_done = true

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

  is_new_high_score = !is_restart

  is_new_high_score = is_new_high_score &&
    cur_player.round.is_keeping_score

  is_new_high_score = is_new_high_score && (
    cur_player.score >
    cur_player.game.board.min_score
  )

  if !is_new_high_score
    set_default_values(cur_player)

    tetris_js(
      cur_player.game.scope,
      JSString(cur_js)
    )

    return false
  end

  cur_js *= """
    \$(".cs-scores-screen").addClass("hidden");
    \$(".js-new-score").removeClass("hidden");
    \$(".js-new-score h2").text("$(lpad(cur_player.score, 8, "0"))");
    \$(".js-new-score input").focus();
  """

  cur_func = function(cur_timer::Timer)
    cur_player.round.is_making_call && return
    send_logs(cur_player, false) || return

    tetris_js(
      cur_player.game.scope,
      JSString(cur_js)
    )

    close(cur_timer)
  end

  Timer(cur_func, 1, 10)

  false
end
