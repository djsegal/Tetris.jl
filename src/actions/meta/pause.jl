function pause(cur_player::AbstractPlayer)
  cur_player.game.in_focus || return

  cur_state = cur_player.state

  cur_state.is_done && return

  is_paused = !cur_state.is_playing

  cur_state.is_playing = !cur_state.is_playing

  is_paused && drop_clock(cur_player)

  cur_js_func = is_paused ? "removeClass" : "addClass"

  cur_js = """
    \$(".js-pause-button").closest("a").$(cur_js_func)("cs-active");
  """

  tetris_js(
    cur_player.game.scope,
    JSString(cur_js)
  )

  return
end
