function push_clock(cur_player::AbstractPlayer)

  cur_uuid = Base.Random.uuid1()

  cur_player.clock.push = cur_uuid

  @async while cur_player.state.is_playing && !cur_player.state.is_done && cur_player.clock.push == cur_uuid && cur_player.round.is_keeping_score

    sleep(10)

    cur_round = cur_player.round

    isempty(cur_round.logs) && continue

    cur_round.is_making_call && continue

    cur_round.is_making_call = true

    cur_log_range = 1:length(cur_round.logs)

    cur_logs = cur_round.logs[cur_log_range]

    cur_batch_count = cur_round.batch_count + 1

    cur_request = Dict(
      "round" => Dict(
        "password" => cur_round.client_password,
        "batch_count" => cur_batch_count,
        "logs_attributes" => cur_logs
      )
    )

    is_successful_request = false

    cur_response = nothing

    try
      cur_response = HTTP.put(
        "$(rounds_endpoint)/$(cur_round.server_id)",
        gzip_headers,
        transcode(GzipCompressor, JSON.json(cur_request))
      )

      is_successful_request = ( cur_response.status == 200 )
    catch cur_error
      any(
        cur_error_type -> isa(cur_error, cur_error_type),
        api_errors
      ) || rethrow(cur_error)
    end

    if is_successful_request
      cur_round.batch_count = cur_batch_count

      deleteat!(cur_round.logs, cur_log_range)
    else
      evaljs(
        cur_player.game.scope,
        JSString("""
          \$(".js-offline").removeClass("hidden");
        """)
      )

      cur_player.round.is_keeping_score = false
    end

    cur_round.is_making_call = false

  end

end
