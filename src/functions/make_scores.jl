function make_scores(cur_board::AbstractBoard, is_mobile::Bool)
  rendered_entries = []

  for (cur_index, cur_entry) in enumerate(cur_board.entries)
    rendered_entry = dom"tr"(
      dom"td"(
        "$(cur_index)",
      ),
      dom"td"(
        "$(rpad(cur_entry.name, 8, "\u00A0"))"[1:8]
      ),
      dom"td"(
        "-",
        attributes=Dict(:class => "hidden-xs")
      ),
      dom"td"(
        "$(lpad(cur_entry.score, 8, "0"))"[1:8]
      )
    )

    push!(rendered_entries, rendered_entry)
  end

  cur_board = dom"table"(
    rendered_entries...,
    attributes=Dict(:class => "cs-score-board")
  )

  if !is_mobile
    cur_board = dom"div"(
      cur_board
    )
  end

  cur_contents = [
    dom"div"(
      dom"h1"(
        "High Scores",
        attributes=Dict(:class => "hidden-xs")
      ),
      dom"h2"(
        "High Scores",
        attributes=Dict(:class => "visible-xs")
      ),
      attributes=Dict(:class => is_mobile ? "" : "col-md-4")
    ),
    dom"div"(
      attributes=Dict(:class => is_mobile ? "" : "col-md-1")
    ),
    dom"div"(
      cur_board,
      attributes=Dict(:class => is_mobile ? "" : "col-md-7")
    )
  ]

  if is_mobile
    cur_contents = [
      dom"div"(
        cur_contents...,
        attributes=Dict(:class => "cs-mobile-scores")
      )
    ]
  end

  cur_row = dom"div"(
    cur_contents...,
    attributes=Dict(:class => "row $(is_mobile ? "visible-sm visible-xs cs-mobile" : "hidden-sm hidden-xs")")
  )

  cur_row
end
