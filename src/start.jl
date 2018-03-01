function start()

  # ---------------
  #  setup styling
  # ---------------

  cur_html = HTML(bundled_assets)

  display(cur_html)

  # ----------------
  #  create objects
  # ----------------

  cur_scope = Scope()

  cur_game = Game()

  cur_player = Player(cur_game)

  # ------------
  #  receive js
  # ------------

  action_observer = Observable(cur_scope, "action", "")

  cur_player.observer.action = action_observer

  on(action_observer) do cur_action
    if cur_action == "play"
      cur_game.in_focus = true
      drop_clock(cur_player)
      return
    end

    if cur_action == "suspend"
      cur_game.in_focus = false
      cur_player.clock.drop =
        Nullable{Base.Random.UUID}()

      return
    end

    if cur_action != "pause"
      cur_player.action = cur_action

      ( cur_action != "" ) &&
        getfield(Tetris, Symbol(cur_action))(cur_player)

      return
    end

    cur_state = cur_player.state
    is_paused = !cur_state.is_playing && !cur_state.has_lost
    cur_state.is_playing = !cur_state.is_playing

    is_paused && drop_clock(cur_player)
  end

  # -------------
  #  render grid
  # -------------

  display(
    cur_scope(
      render(action_observer, cur_player.grid)
    )
  )

  return

end
