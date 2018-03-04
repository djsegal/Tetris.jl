function start()

  # ---------------
  #  setup styling
  # ---------------

  cur_html = HTML(bundled_assets)

  display(cur_html)

  # ----------------
  #  create objects
  # ----------------

  cur_game = Game()

  cur_player = Player(cur_game)

  # ------------
  #  receive js
  # ------------

  action_observer = Observable(cur_game.scope, "action", "")

  cur_player.observer.action = action_observer

  on(action_observer) do cur_action
    if cur_action == "play"
      cur_game.in_focus = true
      drop_clock(cur_player)

      evaljs(
        cur_player.game.scope,
        JSString("""
          \$(".js-splash-screen").addClass("cs-disappear");
        """)
      )

      return
    end

    if cur_action == "suspend"
      cur_game.in_focus = false
      cur_player.clock.drop =
        Nullable{Base.Random.UUID}()

      evaljs(
        cur_player.game.scope,
        JSString("""
          \$(".js-splash-screen").removeClass("cs-disappear");
        """)
      )

      return
    end

    if cur_action != "pause"
      cur_player.action = cur_action

      if cur_action == ""
        cur_player.clock.hold = Nullable{Base.Random.UUID}()
        return
      end

      getfield(Tetris, Symbol(cur_action))(cur_player)

      if cur_action == "left" || cur_action == "right"
        cur_uuid = Base.Random.uuid1()
        cur_player.clock.hold = cur_uuid

        cur_func = function(cur_timer::Timer)
          hold_clock(cur_player, cur_uuid)
        end

        Timer(cur_func, 0.35)
      end

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
    cur_game.scope(
      render(action_observer, cur_player.grid)
    )
  )

  # ----------------
  #  responsiveness
  # ----------------

  evaljs(
    cur_player.game.scope,
    JSString("""
      var cur_container = \$(".js-tetris-container"),
        cur_subarea = cur_container.parent().parent();

      cur_subarea.css("max-width", "100%");
      cur_container[0].scrollIntoViewIfNeeded();
    """)
  )

  return

end
