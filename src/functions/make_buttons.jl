function make_buttons(cur_observer::Observable)
  cur_buttons = dom"div"(
    dom"div"(
      dom"a"(
        dom"i"(
          attributes=Dict(:class => "fab fa-github-alt cs-icon js-github-button")
        ),
        attributes=Dict(
          :href => "https://github.com/djsegal/Tetris.jl",
          :target => "_blank"
        )
      )
    ),
    dom"div"(
      dom"a"(
        dom"i"(
          attributes=Dict(:class => "fas fa-volume-down cs-icon js-music-button")
        ),
        events=Dict("click" => @js function (cur_event)
          if $cur_observer[] == "music"
            $cur_observer[] = "music-music";
          else
            $cur_observer[] = "music";
          end
        end)
      )
    ),
    dom"div"(
      dom"a"(
        dom"i"(
          attributes=Dict(:class => "fas fa-pause cs-icon js-pause-button")
        ),
        events=Dict("click" => @js function (cur_event)
          if $cur_observer[] == "pause"
            $cur_observer[] = "pause-pause";
          else
            $cur_observer[] = "pause";
          end
        end)
      )
    ),
    dom"div"(
      dom"a"(
        dom"i"(
          attributes=Dict(:class => "fas fa-times cs-icon")
        ),
        events=Dict("click" => @js function (cur_event)
          $cur_observer[] = "suspend";

          is_sure = window.confirm("Are you sure you want to restart?");

          if is_sure
            $cur_observer[] = "restart";
          end
        end)
      )
    ),
    attributes=Dict(:class => "cs-icon-list")
  )

  cur_buttons
end
