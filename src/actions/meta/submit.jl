function submit(cur_player::AbstractPlayer, cur_name::AbstractString)

  cur_round = cur_player.round

  cur_request = Dict(
    "score" => Dict(
      "name" => cur_name,
      "round" => Dict(
        "id" => cur_player.round.server_id,
        "password" => cur_player.round.client_password
      )
    )
  )

  did_save_score = false

  cur_response = nothing

  cur_error = nothing

  try
    cur_response = HTTP.post(
      scores_endpoint,
      json_headers,
      JSON.json(cur_request)
    )

    did_save_score = ( cur_response.status == 201 )

    did_save_score || ( cur_error = cur_response )
  catch cur_error
    any(
      cur_error_type -> isa(cur_error, cur_error_type),
      api_errors
    ) || rethrow(cur_error)
  end

  if !did_save_score
    println(cur_error)
    return
  end

  update_scores(cur_player)

  set_default_values(cur_player)

  tetris_js(
    cur_player.game.scope,
    JSString("""
      \$(".cs-scores-screen").removeClass("hidden");
      \$(".js-new-score").addClass("hidden");
      \$(".js-new-score input").val("");
    """)
  )

end
