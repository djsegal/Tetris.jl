# Tetris

[![Build Status](https://travis-ci.org/djsegal/Tetris.jl.svg?branch=master)](https://travis-ci.org/djsegal/Tetris.jl)

[![Coverage Status](https://coveralls.io/repos/djsegal/Tetris.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/djsegal/Tetris.jl?branch=master)

[![codecov.io](http://codecov.io/github/djsegal/Tetris.jl/coverage.svg?branch=master)](http://codecov.io/github/djsegal/Tetris.jl?branch=master)

-----

### Instructions

note: must be using Python 2.x // :(

1) enter this into a julia repl:

```julia
> Pkg.add("WebIO")
> Pkg.checkout("WebIO")
> Pkg.clone("https://github.com/djsegal/Tetris.jl")
```

2) now you can play tetris in jupyter!

```julia
using Tetris

function foo()
  for cur_index in 99:-1:0
    print("$(cur_index) bottles of beer on the wall. ")
    println("$(cur_index) bottles of beer.")
    println("Take one down. Pass it around.")
    sleep(0.5)
  end
end

@tetris foo()
```
