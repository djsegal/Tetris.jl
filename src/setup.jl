function setup()

  # -------------
  #  add styling
  # -------------

  cur_scope = Scope(imports=[
    "https://fonts.googleapis.com/css?family=Press+Start+2P",
    "https://use.fontawesome.com/releases/v5.0.8/js/all.js",
    "/pkg/Tetris/css/arcade.css",
    "/pkg/Tetris/css/colors.css",
    "/pkg/Tetris/css/depth.css",
    "/pkg/Tetris/css/icons.css",
    "/pkg/Tetris/css/shadow.css",
    "/pkg/Tetris/css/splash.css",
    "/pkg/Tetris/css/table.css",
    "/pkg/Tetris/css/style.css"
  ])

  # ----------------
  #  create objects
  # ----------------

  cur_game = Game(cur_scope)

  cur_player = Player(cur_game)

  # ------------
  #  receive js
  # ------------

  action_observer = Observable(cur_game.scope, "action", "")

  on(action_observer) do cur_action

    ( cur_action == "" ) && ( cur_action = "free" )

    if contains(cur_action, "-")
      split_string = Set(split(cur_action, "-"))

      length(split_string) == 1 &&
        ( cur_action = first(split_string) )
    end

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
      \$(".js-tetris-container").closest(".output").css("height", "auto");
      \$(".js-tetris-container").closest(".output_subarea").css("max-width", "100%");
      \$(".js-tetris-container").closest(".cell")[0].scrollIntoView();
    """)
  )

  return

end
