function render(cur_observer::Observable, cur_grid::AbstractGrid)
  cur_row_array = Array{Node}(0)

  total_rows = cur_grid.rows + cur_grid.hidden_rows

  for cur_row in total_rows:-1:1

    cur_cell_array = Array{Node}(0)

    for cur_col in 1:cur_grid.cols
      push!(
        cur_cell_array,
        Node(:td, attributes=Dict(:class => "cs-light-grey"))
      )
    end

    cur_class = "cs-row-$(cur_row)"

    ( cur_row > cur_grid.rows ) && ( cur_class *= " hidden" )

    push!(
      cur_row_array,
      Node(
        :tr,
        cur_cell_array...,
        attributes=Dict(:class => cur_class)
      )
    )

  end

  cur_table = Node(
    :table,
    cur_row_array...,
    attributes=Dict(:class => "cs-tetris-table z-depth-1")
  )

  cur_events = Dict()

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
    if ( cur_key_code == 69 ) ; is_arrow_key = true ; $cur_observer[] = "clock" ; end

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
  end

  cur_container = dom"div[tabindex=1]"(
    cur_table,
    attributes=Dict(:class => "js-tetris-container cs-tetris-container"),
    events=cur_events
  )

  cur_container
end
