function suspend(cur_player::AbstractPlayer)
  cur_game = cur_player.game

  cur_game.in_focus = false

  cur_player.clock.push = Nullable{UUIDs.UUID}()
  cur_player.clock.drop = Nullable{UUIDs.UUID}()

  tetris_js(
    cur_player.game.scope,
    JSString("""
      \$(".js-tetris-container").addClass("cs-has-splash");
      \$(".js-splash-screen").removeClass("cs-disappear");

      \$(".js-pause-button").closest("a").removeClass("cs-active");
    """)
  )

  return
end
