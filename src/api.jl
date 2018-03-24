score_api = "http://localhost:3000"

upload_endpoint = "$(score_api)/rounds"

default_headers = Dict(
  "Content-Type" => "application/json",
  "Accept" => "application/json"
)

api_errors = [
  HTTP.ExceptionRequest.StatusError,
  Base.UVError
]

function api_parse(cur_response::HTTP.Response, cur_field::AbstractString)
  JSON.parse(
    String(cur_response.body)
  )[cur_field]
end
