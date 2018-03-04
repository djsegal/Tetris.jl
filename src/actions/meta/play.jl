function play(cur_player::AbstractPlayer)
  cur_game = cur_player.game

  cur_game.in_focus = true

  drop_clock(cur_player)

  evaljs(
    cur_game.scope,
    JSString("""
      \$(".js-splash-screen").addClass("cs-disappear");
    """)
  )

  return
end
