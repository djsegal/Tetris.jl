module Tetris

  using Revise
  using JSExpr

  using WebIO
  using DataStructures

  include("abstracts.jl")
  include("structs/index.jl")
  include("clocks/index.jl")

  include("assets/index.jl")
  include("layouts/index.jl")
  include("tetrominoes/index.jl")

  include("functions/index.jl")
  include("actions/index.jl")

  include("start.jl")

  macro tetris(cur_expr::Expr)
    cur_expr = quote
      start()

      $(
        Expr(
          :macrocall,
          Symbol("@async"),
          esc(cur_expr)
        )
      )
    end

    return cur_expr
  end

  export @tetris

end
