mutable struct Board{T <: Vector{<:AbstractEntry}} <: AbstractBoard
  entries::T
end

function Board()
  has_high_scores = false

  cur_response = nothing

  try
    cur_response = HTTP.get(
      download_endpoint,
      default_headers
    )

    has_high_scores = ( cur_response.status == 200 )
  catch cur_error
    any(
      cur_error_type -> isa(cur_error, cur_error_type),
      api_errors
    ) || rethrow(cur_error)

    println("todo: fix this")
  end

  cur_entries = Entry[]

  raw_entries = has_high_scores ?
    api_fetch(cur_response) : []

  for raw_entry in raw_entries
    cur_entry = Entry(
      raw_entry["name"],
      raw_entry["value"]
    )

    push!(cur_entries, cur_entry)
  end

  cur_board = Board(cur_entries)

  cur_board
end
