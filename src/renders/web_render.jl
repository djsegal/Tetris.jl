function web_render(cur_observer::Observable, cur_grid::AbstractGrid)
  cur_table = make_table(cur_grid.rows, cur_grid.cols, cur_grid.hidden_rows)

  cur_events = Dict()

  cur_events["dblclick"] = @js function (cur_event)
    $cur_observer[] = "play";
  end

  cur_events["blur"] = @js function (cur_event)
    $cur_observer[] = "suspend";
  end

  cur_events["keydown"] = @js function (cur_event)

    cur_key_code = cur_event.keyCode;

    is_action_key = false;

    if cur_event.target.tagName.toLowerCase() !== "input"

      if ( cur_key_code == 77 ) ; is_action_key = true ; $cur_observer[] = "music" ; end

      if ( cur_key_code == 80 ) ; is_action_key = true ; $cur_observer[] = "pause" ; end

      if ( cur_key_code == 37 ) ; is_action_key = true ; $cur_observer[] = "slide_left" ; end
      if ( cur_key_code == 38 ) ; is_action_key = true ; $cur_observer[] = "clockwise" ; end
      if ( cur_key_code == 39 ) ; is_action_key = true ; $cur_observer[] = "slide_right" ; end
      if ( cur_key_code == 40 ) ; is_action_key = true ; $cur_observer[] = "soft_drop" ; end

      if ( cur_key_code == 32 ) ; is_action_key = true ; $cur_observer[] = "hard_drop" ; end

      if ( cur_key_code == 67 ) ; is_action_key = true ; $cur_observer[] = "hold" ; end
      if ( cur_key_code == 90 ) ; is_action_key = true ; $cur_observer[] = "counter" ; end

    end

    if is_action_key ; cur_event.preventDefault() ; end

  end

  cur_events["keyup"] = @js function (cur_event)

    cur_key_code = cur_event.keyCode;

    is_action_key = false;

    if cur_event.target.tagName.toLowerCase() !== "input"

      if ( cur_key_code == 77 ) ; is_action_key = true ; $cur_observer[] = "" ; end

      if ( cur_key_code == 80 ) ; is_action_key = true ; $cur_observer[] = "" ; end

      if ( cur_key_code == 37 ) ; is_action_key = true ; $cur_observer[] = "" ; end
      if ( cur_key_code == 38 ) ; is_action_key = true ; $cur_observer[] = "" ; end
      if ( cur_key_code == 39 ) ; is_action_key = true ; $cur_observer[] = "" ; end
      if ( cur_key_code == 40 ) ; is_action_key = true ; $cur_observer[] = "" ; end

      if ( cur_key_code == 32 ) ; is_action_key = true ; $cur_observer[] = "" ; end

      if ( cur_key_code == 67 ) ; is_action_key = true ; $cur_observer[] = "" ; end
      if ( cur_key_code == 90 ) ; is_action_key = true ; $cur_observer[] = "" ; end

    end

    if is_action_key ; cur_event.preventDefault() ; end

  end

  cur_events["keypress"] = @js function (cur_event)

    if cur_event.target.tagName.toLowerCase() !== "input"

      cur_event.preventDefault();

    end

  end

  cur_preview_tables = []

  for cur_preview in 1:cur_grid.player.bag.previews
    push!(
      cur_preview_tables,
      make_table(2, 4, class_names="cs-preview-piece js-preview-piece js-preview-piece__$(cur_preview)")
    )
  end

  cur_side_bar = Node(
    :div,
    dom"h1"(
      "Level 1",
      attributes=Dict(:class => "cs-level-text js-level-text")
    ),
    make_table(2, 4, class_names="cs-hold-piece js-hold-piece"),
    cur_preview_tables...,
    dom"h2"(
      "00000000",
      attributes=Dict(:class => "cs-score-text js-score-text")
    ),
    attributes=Dict(:class => "col-sm-5 cs-col hidden-xs cs-side-bar")
  )

  cur_container = dom"div[tabindex=1]"(
    dom"div"(
      dom"div"(
        cur_table,
        attributes=Dict(:class => "col-sm-7 cs-col cs-main-area")
      ),
      cur_side_bar,
      attributes=Dict(:class => "row")
    ),
    dom"div"(
      dom"div"(
        dom"h1"("tetris."),
        dom"div"("double-click to play."),
        attributes=Dict(:class => "cs-splash-text js-splash-text")
      ),
      dom"div"(
        dom"div"("⬆️⬆️⬇️⬇️⬅️➡️⬅️➡️"),
        dom"div"("c. z. space bar"),
        attributes=Dict(:class => "cs-how-to")
      ),
      attributes=Dict(:class => "cs-overlay-screen cs-splash-screen js-splash-screen cs-blue-grey")
    ),
    dom"div"(
      make_buttons(cur_observer),
      attributes=Dict(:class => "cs-overlay-screen")
    ),
    dom"div"(
      dom"div"(
        make_scores(cur_grid.player.game.board, true),
        make_scores(cur_grid.player.game.board, false),
        attributes=Dict(:class => "cs-jumbotron jumbotron")
      ),
      attributes=Dict(:class => "cs-overlay-screen cs-scores-screen $(isempty(cur_grid.player.game.board.entries) ? "hidden" : "")")
    ),
    dom"div"(
      dom"div"(
        dom"div"(
          dom"div"(
            dom"h1"(
              "New High Score!",
            ),
            dom"h2"(
              lpad(0, 8, "0")
            ),
            dom"form"(
              dom"input"(
                attributes=Dict(
                  :class => "form-control",
                  :type => "text",
                  :placeholder => "________",
                  :maxlength => 8,
                  :method => "post",
                  :required => "true"
                )
              ),
              events=Dict(
                "submit" => @js function (cur_event)
                  curName = document.querySelector(".cs-new-score input").value;

                  $cur_observer[] = "submit-" + curName;
                  cur_event.preventDefault();
                end
              ),
              attributes=Dict(:class => "js-form")
            ),
            attributes=Dict(:class => "cs-new-score")
          ),
          attributes=Dict(:class => "row")
        ),
        attributes=Dict(:class => "cs-jumbotron jumbotron")
      ),
      attributes=Dict(:class => "cs-overlay-screen cs-scores-screen js-new-score hidden")
    ),
    dom"div"(
      attributes=Dict(:class => "cs-offline js-offline hidden", :title => "You are offline.")
    ),
    attributes=Dict(:class => "js-tetris-container cs-tetris-container container-fluid cs-has-splash"),
    events=cur_events
  )

  cur_container
end
