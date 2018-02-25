function start()

  cur_game = Game()

  cur_player = Player(cur_game)

  cur_html = bundled_assets

  cur_html *= grid_layout(cur_player.grid)

  display(HTML(cur_html))

  cur_player.is_playing = true

  while cur_player.is_playing
    step(cur_player)
    sleep(0.05)
  end

  return

end
