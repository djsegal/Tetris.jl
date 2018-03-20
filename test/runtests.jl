using Tetris
using Base.Test

@test isdefined(Main, Symbol("@tetris"))
@test isdefined(Tetris, :setup)
