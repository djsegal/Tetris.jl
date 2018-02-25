module Tetris

  using Revise

  include("abstracts.jl")
  include("structs.jl")
  include("constructors.jl")

  include("assets/index.jl")
  include("layouts/index.jl")
  include("tetrominoes/index.jl")

  include("functions/index.jl")
  include("start.jl")

end
