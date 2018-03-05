function render(cur_observer::Observable, cur_grid::AbstractGrid)
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

    is_arrow_key = false;

    if ( cur_key_code == 37 ) ; is_arrow_key = true ; $cur_observer[] = "left" ; end
    if ( cur_key_code == 38 ) ; is_arrow_key = true ; $cur_observer[] = "up" ; end
    if ( cur_key_code == 39 ) ; is_arrow_key = true ; $cur_observer[] = "right" ; end
    if ( cur_key_code == 40 ) ; is_arrow_key = true ; $cur_observer[] = "down" ; end

    if ( cur_key_code == 65 ) ; is_arrow_key = true ; $cur_observer[] = "left" ; end
    if ( cur_key_code == 87 ) ; is_arrow_key = true ; $cur_observer[] = "up" ; end
    if ( cur_key_code == 68 ) ; is_arrow_key = true ; $cur_observer[] = "right" ; end
    if ( cur_key_code == 83 ) ; is_arrow_key = true ; $cur_observer[] = "down" ; end

    if ( cur_key_code == 81 ) ; is_arrow_key = true ; $cur_observer[] = "counter" ; end
    if ( cur_key_code == 69 ) ; is_arrow_key = true ; $cur_observer[] = "clockwise" ; end

    if ( cur_key_code == 80 ) ; is_arrow_key = true ; $cur_observer[] = "pause" ; end

    if ( cur_key_code == 32 ) ; is_arrow_key = true ; $cur_observer[] = "hold" ; end

    if is_arrow_key ; cur_event.preventDefault() ; end

  end

  cur_events["keyup"] = @js function (cur_event)

    cur_key_code = cur_event.keyCode;

    if ( cur_key_code == 37 ) ; $cur_observer[] = "" ; end
    if ( cur_key_code == 38 ) ; $cur_observer[] = "" ; end
    if ( cur_key_code == 39 ) ; $cur_observer[] = "" ; end
    if ( cur_key_code == 40 ) ; $cur_observer[] = "" ; end

    if ( cur_key_code == 65 ) ; $cur_observer[] = "" ; end
    if ( cur_key_code == 87 ) ; $cur_observer[] = "" ; end
    if ( cur_key_code == 68 ) ; $cur_observer[] = "" ; end
    if ( cur_key_code == 83 ) ; $cur_observer[] = "" ; end

    if ( cur_key_code == 81 ) ; $cur_observer[] = "" ; end
    if ( cur_key_code == 69 ) ; $cur_observer[] = "" ; end

    if ( cur_key_code == 80 ) ; $cur_observer[] = "" ; end

    if ( cur_key_code == 32 ) ; $cur_observer[] = "" ; end

  end

  cur_container = dom"div[tabindex=1]"(
    dom"div"(
      dom"div"(
        cur_table,
        attributes=Dict(:class => "col-sm-7 cs-col cs-main-area")
      ),
      attributes=Dict(:class => "row")
    ),
    dom"div"(
      dom"div"(
        dom"h1"("tetris."),
        dom"div"("double-click to play."),
        attributes=Dict(:class => "cs-splash-text")
      ),
      dom"div"(
        dom"div"("⬆️⬆️⬇️⬇️⬅️➡️⬅️➡️"),
        dom"div"("q. e. space"),
        attributes=Dict(:class => "cs-how-to")
      ),
      attributes=Dict(:class => "cs-splash-screen js-splash-screen cs-blue-grey")
    ),
    attributes=Dict(:class => "js-tetris-container cs-tetris-container container-fluid"),
    events=cur_events
  )

  cur_container
end
