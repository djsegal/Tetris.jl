module Tetris

  using HTTP
  using JSON

  using WebIO
  using JSExpr

  using DataStructures
  using CodecZlib

  using Colors
  using Crayons

  using Nullables
  using UUIDs

  using Dates
  using REPL

  using Random

  include("abstracts.jl")
  include("consts.jl")
  include("api.jl")

  include("structs/index.jl")
  include("clocks/index.jl")

  include("renders/index.jl")
  include("tetrominoes/index.jl")

  include("functions/index.jl")
  include("actions/index.jl")

  include("raw_terminal.jl")
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

  function tetris_js(cur_scope::Scope, cur_string::JSString)
    is_repl && return
    evaljs(cur_scope, cur_string)
  end

  function __init__()
    global terminal

    global is_ijulia
    global is_juno
    global is_vscode
    global is_ide
    global is_repl

    terminal = REPL.Terminals.TTYTerminal(
      get(ENV, "TERM", Sys.iswindows() ? "" : "dumb"),
      stdin, stdout, stderr
    )

    is_ijulia = isdefined(Main, :IJulia) && Main.IJulia.inited
    is_juno = isdefined(Main, :Juno) && Main.Juno.isactive()
    is_vscode = isdefined(Main, :_vscodeserver)

    is_ide = is_ijulia || is_juno || is_vscode
    is_repl = !is_ide
  end

end
