function score!(cur_player::AbstractPlayer, cur_label::AbstractString, cur_value::Int)

  # --------------------
  #  verify score comes
  #   from valid label
  # --------------------

  in(cur_label, allowed_labels) ||
    error("Invalid label in score call.")

  # ---------------------
  #  calculate the score
  # ---------------------

  cur_function = getfield(
    Tetris,
    Symbol("_score_$(cur_label)")
  )

  cur_level = cur_player.level

  cur_combo = cur_player.combo

  cur_score = cur_function(cur_value, cur_level, cur_combo)

  # ---------------------
  #  update player score
  # ---------------------

  cur_player.score += cur_score

  return

end

function _score_clear(cleared_count::Int, cur_level::Int, cur_combo::Int)
  cur_score = score_array[cleared_count]

  cur_score *= cur_level

  cur_score
end

function _score_combo(cleared_count::Int, cur_level::Int, cur_combo::Int)
  cur_score = ( cleared_count == 1 ) ? 20 : 50

  cur_score *= cur_combo

  cur_score *= cur_level

  cur_score
end
