function music(cur_player::AbstractPlayer)

  cur_js = """

    if (typeof tetrisMusic !== 'undefined') {

      if ( tetrisMusic.playing() ) {
        tetrisMusic.pause();
        \$(".js-music-button").closest("a").removeClass("cs-active");
      } else {
        tetrisMusic.play();
        \$(".js-music-button").closest("a").addClass("cs-active");
      }

    }

  """

  tetris_js(
    cur_player.game.scope,
    JSString(cur_js)
  )

end
