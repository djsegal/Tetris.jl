function start()

  # --------------
  #  send styling
  # --------------

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

    ( cur_action == "" ) && ( cur_action = "free" )

    getfield(Tetris, Symbol(cur_action))(cur_player)

    in(cur_action, ["left", "right"]) || return

    cur_player.action = cur_action

    cur_uuid = Base.Random.uuid1()
    cur_player.clock.hold = cur_uuid

    cur_func = function(cur_timer::Timer)
      hold_clock(cur_player, cur_uuid)
    end

    Timer(cur_func, 0.35)

    return

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
    cur_game.scope,
    JSString("""
      \$(".js-tetris-container").closest(".output_subarea").css("max-width", "100%");
      \$(".js-tetris-container").closest(".cell")[0].scrollIntoView();
    """)
  )

  return

end
