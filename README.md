# Tetris

music by: [Ghost & Kozmos](https://soundcloud.com/the-ghost-that-haunts-your-house/ghost-kozmos-tetris-theme-electro-swing-remix)

[![Build Status](https://travis-ci.org/djsegal/Tetris.jl.svg?branch=master)](https://travis-ci.org/djsegal/Tetris.jl)
[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/djsegal/webio-binder/master?filepath=Tetris.jl.ipynb)

-----

### Instructions

note: must be using Python 2.x // :(

1) enter this into a julia repl:

```julia
> Pkg.clone("https://github.com/djsegal/Tetris.jl")
> Pkg.build("WebIO")
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
