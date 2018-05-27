mutable struct Round{T <: Vector{<:AbstractLog}} <: AbstractRound
  player::AbstractPlayer
  logs::T

  batch_count::Int
  log_count::Int

  is_keeping_score::Bool
  is_making_call::Bool

  server_id::Int
  client_password::AbstractString
end

function Round(cur_player::AbstractPlayer=Player())
  cur_password = string(Base.Random.uuid4())

  cur_batch_count = 0
  cur_log_count = 1

  cur_request = Dict(
    "round" => Dict(
      "password" => cur_password,
      "batch_count" => cur_batch_count
    )
  )

  cur_is_keeping_score = false

  cur_response = nothing

  try
    cur_response = HTTP.post(
      rounds_endpoint,
      json_headers,
      JSON.json(cur_request)
    )

    cur_is_keeping_score = ( cur_response.status == 201 )
  catch cur_error
    any(
      cur_error_type -> isa(cur_error, cur_error_type),
      api_errors
    ) || rethrow(cur_error)

    tetris_js(
      cur_player.game.scope,
      JSString("""
        \$(".js-offline").removeClass("hidden");
      """)
    )
  end

  cur_server_id = cur_is_keeping_score ?
    api_fetch(cur_response, "id") : -1

  cur_round = Round(
    cur_player,
    AbstractLog[],
    cur_batch_count,
    cur_log_count,
    cur_is_keeping_score,
    false,
    cur_server_id,
    cur_password
  )

  cur_player.round = cur_round

  cur_round
end
