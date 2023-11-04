function setup()

  # -------------
  #  add styling
  # -------------

  relative_dir = is_ijulia ? "" : "/"

  cur_scope = Scope(imports=[
    pkgdir(@__MODULE__, "assets/js/fonts.js"),
    pkgdir(@__MODULE__, "assets/js/howler.js"),
    pkgdir(@__MODULE__, "assets/css/fonts.css"),
    pkgdir(@__MODULE__, "assets/css/offline.css"),
    pkgdir(@__MODULE__, "assets/css/arcade.css"),
    pkgdir(@__MODULE__, "assets/css/scores.css"),
    pkgdir(@__MODULE__, "assets/css/colors.css"),
    pkgdir(@__MODULE__, "assets/css/depth.css"),
    pkgdir(@__MODULE__, "assets/css/icons.css"),
    pkgdir(@__MODULE__, "assets/css/shadow.css"),
    pkgdir(@__MODULE__, "assets/css/splash.css"),
    pkgdir(@__MODULE__, "assets/css/table.css"),
    pkgdir(@__MODULE__, "assets/css/style.css")
  ])

  # ----------------
  #  create objects
  # ----------------

  cur_game = Game(cur_scope)

  cur_player = Player(cur_game)

  cur_round = Round(cur_player)

  # ------------
  #  receive js
  # ------------

  action_observer = Observable(cur_game.scope, "action", "")

  on(action_observer) do cur_action

    ( cur_action == "" ) && ( cur_action = "free" )

    if contains(cur_action, "-")
      split_string = Set(split(cur_action, "-", limit=2))

      length(split_string) == 1 &&
        ( cur_action = first(split_string) )

      if in("submit", split_string) && length(split_string) == 2
        cur_action = "submit"

        delete!(split_string, "submit")

        getfield(Tetris, Symbol(cur_action))(
          cur_player, pop!(split_string)
        )

        return
      end
    end

    getfield(Tetris, Symbol(cur_action))(cur_player)

    in(cur_action, ["slide_left", "slide_right", "soft_drop"]) || return

    cur_player.action = cur_action

    cur_uuid = UUIDs.uuid4()
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

  if is_repl
    repl_render(cur_player)
  else
    cur_render = cur_game.scope(
      web_render(action_observer, cur_player.grid)
    )

    display(cur_render)
  end

  # ------------
  #  load music
  # ------------

  music_path = AssetRegistry.register(
    pkgdir(@__MODULE__, "assets/tetris-theme.mp3")
  )

  music_js = """
    var tetrisMusic = window.tetrisMusic;

    if (typeof tetrisMusic !== 'undefined') {
      tetrisMusic.unload();
    }

    window.tetrisMusic = new Howl({
      src: [\"""" * music_path * """\"],
      loop: true
    });

    // this is needed to have the
    // script run for some reason:
    console.log("Music loaded.");
  """

  tetris_js(
    cur_game.scope,
    JSString(music_js)
  )

  # ----------------
  #  responsiveness
  # ----------------

  tetris_js(
    cur_game.scope,
    JSString("""
      \$(".js-tetris-container").closest(".output").css("height", "auto");
      \$(".js-tetris-container").closest(".output_subarea").css("max-width", "100%");
      \$(".js-tetris-container").closest(".cell")[0].scrollIntoViewIfNeeded();
    """)
  )

  return cur_game

end
