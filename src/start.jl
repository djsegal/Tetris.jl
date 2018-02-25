function start()

  cur_game = Game()

  cur_player = Player(cur_game)

  cur_html = ""

  cur_html *= colors_asset()

  cur_html *= depth_asset()

  cur_html *= style_asset()

  cur_html *= grid_layout()

  HTML(cur_html)

end
