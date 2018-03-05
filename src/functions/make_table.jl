function make_table(cur_rows::Int, cur_cols::Int, cur_hidden_rows::Int=0; class_names::AbstractString="")
  cur_row_array = Array{Node}(0)

  total_rows = cur_rows + cur_hidden_rows

  for cur_row in total_rows:-1:1

    cur_cell_array = Array{Node}(0)

    for cur_col in 1:cur_cols
      push!(
        cur_cell_array,
        Node(:td)
      )
    end

    cur_class = "cs-row-$(cur_row)"

    is_hidden_row = ( cur_row > cur_rows )

    if is_hidden_row
      cur_class *= " hidden"
    else
      cur_class *= " cs-light-grey"
    end

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
    attributes=Dict(:class => "cs-tetris-table z-depth-1-half $(class_names)")
  )

  cur_table
end
