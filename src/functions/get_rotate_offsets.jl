function get_rotate_offsets(initial_rotation::Int, final_rotation::Int, is_even_width::Bool)
  tmp_array = [initial_rotation, final_rotation]
  cur_key = sort(tmp_array)

  if first(diff(cur_key)) == 1
    is_clockwise = ( cur_key == tmp_array )
  else
    is_clockwise = ( cur_key != tmp_array )
  end

  if is_even_width
    cur_offsets = even_offsets[cur_key]
  else
    cur_offsets = odd_offsets[cur_key]
  end

  is_clockwise && return cur_offsets

  cur_offsets = map(
    cur_offset -> map(
      cur_value -> ( cur_value * -1 ),
      cur_offset
    ),
    cur_offsets
  )

  return cur_offsets
end
