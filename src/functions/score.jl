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

  ( cur_label == "glue" ) &&
    ( cur_label = "soft" )

  # ---------------------
  #  calculate the score
  # ---------------------

  cur_dict = OrderedDict(
    "level" => cur_player.level,
    "lines" => cur_player.lines,
    "combo" => cur_player.combo,
    "stash" => cur_player.stash
  )

  cur_function = getfield(
    Tetris,
    Symbol("_score_$(cur_label)")
  )

  cur_score = cur_function(cur_value, cur_dict)

  # ---------------------
  #  update player score
  # ---------------------

  if cur_label == "soft"
    cur_player.stash = 0
  else
    cur_player.score += cur_score
  end

  return cur_score

end

function _score_clear(cleared_count::Int, cur_dict::OrderedDict)
  cur_score = score_array[cleared_count]

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

function _score_soft(stub_value::Int, cur_dict::OrderedDict)
  cur_score = cur_dict["stash"]

  cur_score
end