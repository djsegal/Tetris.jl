function score!(cur_player::AbstractPlayer, cur_label::AbstractString, cur_value::Int)

  # --------------------
  #  verify score comes
  #   from valid label
  # --------------------

  in(cur_label, allowed_labels) ||
    error("Invalid label in score call: $(cur_label).")

  # ------------------
  #  handle soft drop
  # ------------------

  if cur_label == "soft"
    cur_player.score += 1
    cur_player.stash += 1

    return 1
  end

  # ---------------------
  #  calculate the score
  # ---------------------

  cur_dict = OrderedDict(
    "level" => cur_player.level,
    "lines" => cur_player.lines,
    "combo" => cur_player.combo,
    "stash" => cur_player.stash,
    "glues" => cur_player.glues,
    "total" => cur_player.score,
    "chain" => cur_player.chain,
    "piece" => cur_player.piece.name
  )

  cur_function = getfield(
    Tetris,
    Symbol("_score_$(cur_label)")
  )

  cur_score = cur_function(cur_value, cur_dict)

  # -------------------
  #  log current score
  # -------------------

  cur_round = cur_player.round

  if cur_round.is_keeping_score
    cur_position, cur_round.log_count =
      [0, 1] + cur_round.log_count

    cur_log = Log(
      cur_position,
      cur_label,
      cur_value,
      cur_score,
      values(cur_dict)...
    )

    push!(cur_round.logs, cur_log)
  end

  # ---------------------
  #  update player score
  # ---------------------

  if cur_label == "glue" || cur_label == "hold"
    cur_player.stash = 0
  else
    cur_player.score += cur_score
  end

  if is_repl
    cur_string = []
    push!(cur_string, crayon_dict["grey"])
    push!(cur_string, "\x1b[$(14);$(11)H")
    push!(cur_string, lpad(cur_player.score, 8, "0"))
    push!(cur_string, inv(crayon_dict["grey"]))
    push!(cur_string, "\x1b[u")
    print(cur_string...)
  end

  return cur_score

end

function _score_clear(cleared_count::Int, cur_dict::OrderedDict)
  if cleared_count == 4 && cur_dict["chain"] == "tetris"
    cur_score = 1200
  else
    cur_score = score_array[cleared_count]
  end

  cur_score *= cur_dict["level"]

  cur_score
end

function _score_combo(cleared_count::Int, cur_dict::OrderedDict)
  cur_score = ( cleared_count == 1 ) ? 20 : 50

  cur_score *= cur_dict["combo"]

  cur_score *= cur_dict["level"]

  cur_score
end

function _score_hard(drop_count::Int, cur_dict::OrderedDict)
  cur_score = drop_count

  cur_score *= 2

  cur_score
end

function _score_glue(stub_value::Int, cur_dict::OrderedDict)
  cur_score = cur_dict["stash"]

  cur_score
end

function _score_hold(stub_value::Int, cur_dict::OrderedDict)
  cur_score = cur_dict["stash"]

  cur_score
end
