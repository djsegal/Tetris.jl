function start()

  # @manipulate for is_playing in [true, false]
    cur_game = setup()

    cur_player = cur_game.players[1]

    cur_player.is_playing = true

  # cur_html = """
  #   <script class="cs-step-script">
  #     \$(".cs-step-script").parent().css("padding", 0);
  #     \$(".js-tetris-container").focus();
  #   </script>
  # """

  # display(HTML(cur_html))

    for asdf in 1:3
    # while cur_player.is_playing
      # println("40404")
      # println(is_playing)
      step(cur_player)
      sleep(0.5)
      # println("404041")
      # println(cur_player.is_playing)
      # println(is_playing)
      # cur_player.is_playing = is_playing
      # println(cur_player.is_playing)
    end
  # end

  return

end
