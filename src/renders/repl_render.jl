function repl_render(cur_player::AbstractPlayer)
  cur_string = []

  push!(cur_string, "\x1b[2J")

  push!(cur_string, crayon_dict["grey"])

  for cur_row in 1:cur_player.grid.rows
    push!(cur_string, "\n")
    push!(cur_string, "        \u2590")
    for cur_col in 1:cur_player.grid.cols
      push!(cur_string, "  ")
    end
    push!(cur_string, "\u258C ")
  end

  push!(cur_string, "\n")
  push!(cur_string, "        \u2580")
  for cur_col in 1:cur_player.grid.cols
    push!(cur_string, "\u2580\u2580")
  end
  push!(cur_string, "\u2580 ")
  push!(cur_string, "\n")
  push!(cur_string, "\x1b[s")

  print(cur_string...)

  raw_terminal() do
    while true
      tmp_input = readavailable(terminal.in_stream)

      if !cur_player.game.in_focus
        play(cur_player)
        continue
      end

      cur_player.state.is_playing || break

      if ( tmp_input == UInt8[0x1b] )
        cur_player.state.is_playing = false
        continue
      end

      ( tmp_input == UInt8[0x1b, 0x5b, 0x44] ) && slide_left(cur_player)
      ( tmp_input == UInt8[0x1b, 0x5b, 0x43] ) && slide_right(cur_player)
      ( tmp_input == UInt8[0x1b, 0x5b, 0x42] ) && soft_drop(cur_player)
      ( tmp_input == UInt8[0x1b, 0x5b, 0x41] ) && clockwise(cur_player)

      tmp_input = String(tmp_input)

      ( tmp_input == "c" ) && hold(cur_player)
      ( tmp_input == "z" ) && counter(cur_player)
      ( tmp_input == "p" ) && pause(cur_player)
      ( tmp_input == " " ) && hard_drop(cur_player)
    end
  end
end
