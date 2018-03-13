function github(cur_player::AbstractPlayer)

  cur_js = """

    window.open("https://github.com/djsegal/Tetris.jl", "_blank");

  """

  evaljs(
    cur_player.game.scope,
    JSString(cur_js)
  )

end
