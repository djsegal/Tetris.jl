function repl_render(cur_player::AbstractPlayer)
  cur_string = []

  push!(cur_string, "\x1b[2J")

  push!(cur_string, crayon_dict["grey"])

  main_chunk = "\u258C" * " " ^ 20 * "\u2590"

  plain_row = " " ^ 29 * main_chunk * "\n"

  card_top_chunk = " " ^ 9 * "\u2584" ^ 10 * " " ^ 10

  card_top = card_top_chunk * main_chunk * reverse(card_top_chunk) * "\n"

  card_mid_chunk = " " ^ 9 * "\u258C" * " " ^ 8 * "\u2590" * " " ^ 9

  card_mid = card_mid_chunk * " " * main_chunk * " " * card_mid_chunk * "\n"

  card_bot_chunk = " " ^ 9 * "\u2580" ^ 10 * " " ^ 10

  card_bot = card_bot_chunk * main_chunk * reverse(card_bot_chunk) * "\n"

  bottom_row = " " ^ 29 * "\u2580" ^ 22 * "\n"

  push!(cur_string, plain_row)
  push!(cur_string, plain_row)

  for cur_index in 1:3
    push!(cur_string, card_top)
    push!(cur_string, card_mid)
    push!(cur_string, card_mid)
    push!(cur_string, card_bot)
    push!(cur_string, plain_row)
    push!(cur_string, plain_row)
  end

  push!(cur_string, bottom_row)

  push!(cur_string, "\x1b[s")

  push!(cur_string, "\x1b[7;11H")
  push!(cur_string, " level: ")

  push!(cur_string, "\x1b[8;11H")
  push!(cur_string, "   $(lpad(cur_player.level, 2, "0"))   ")

  push!(cur_string, "\x1b[13;11H")
  push!(cur_string, " score: ")

  push!(cur_string, "\x1b[14;11H")
  push!(cur_string, lpad(cur_player.score, 8, "0"))

  push!(cur_string, inv(crayon_dict["grey"]))

  push!(cur_string, "\x1b[u")
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
