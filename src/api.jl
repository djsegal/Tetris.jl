score_api = "http://localhost:3000"

upload_endpoint = "$(score_api)/rounds"

download_endpoint = "$(score_api)/scores"

default_headers = Dict(
  "Content-Type" => "application/json",
  "Accept" => "application/json"
)

api_errors = [
  HTTP.ExceptionRequest.StatusError,
  Base.UVError
]

function api_fetch(cur_response::HTTP.Response, cur_key::Union{AbstractString, Int, Void}=nothing)
  cur_fetch = JSON.parse(
    String(cur_response.body)
  )

  ( cur_key == nothing ) ||
    ( cur_fetch = cur_fetch[cur_key] )

  cur_fetch
end
