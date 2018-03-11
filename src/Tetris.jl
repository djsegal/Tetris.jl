module Tetris

  using Revise
  using JSExpr

  using WebIO
  using DataStructures

  include("abstracts.jl")
  include("consts.jl")

  include("structs/index.jl")
  include("clocks/index.jl")

  include("layouts/index.jl")
  include("tetrominoes/index.jl")

  include("functions/index.jl")
  include("actions/index.jl")

  include("setup.jl")

  macro tetris(cur_expr::Expr)
    cur_expr = quote
      setup()

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
