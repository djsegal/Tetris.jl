mutable struct Board{T <: Vector{<:AbstractEntry}} <: AbstractBoard
  entries::T
  min_score::Int
end

function Board()
  has_high_scores = false

  cur_response = nothing

  try
    cur_response = HTTP.get(
      scores_endpoint,
      json_headers
    )

    has_high_scores = ( cur_response.status == 200 )
  catch cur_error
    any(
      cur_error_type -> isa(cur_error, cur_error_type),
      api_errors
    ) || rethrow(cur_error)
  end

  cur_entries = Entry[]

  if has_high_scores
    raw_entries = api_fetch(cur_response)

    if isempty(raw_entries)
      min_score = 0
    else
      min_score = minimum(
        map(raw_entry -> raw_entry["value"], raw_entries)
      )
    end
  else
    raw_entries = []
    min_score = 0
  end

  for raw_entry in raw_entries
    cur_entry = Entry(
      raw_entry["name"],
      raw_entry["value"]
    )

    push!(cur_entries, cur_entry)
  end

  cur_board = Board(
    cur_entries,
    min_score
  )

  cur_board
end
