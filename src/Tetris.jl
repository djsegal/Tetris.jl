module Tetris

  using Revise
  using JSExpr

  using WebIO

  include("abstracts.jl")
  include("structs.jl")
  include("constructors.jl")

  include("assets/index.jl")
  include("layouts/index.jl")
  include("tetrominoes/index.jl")

  include("functions/index.jl")
  include("actions/index.jl")

  include("setup.jl")
  include("start.jl")

end
