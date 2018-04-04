# Tetris

music by: [Ghost & Kozmos](https://soundcloud.com/the-ghost-that-haunts-your-house/ghost-kozmos-tetris-theme-electro-swing-remix)

[![Build Status](https://travis-ci.org/djsegal/Tetris.jl.svg?branch=master)](https://travis-ci.org/djsegal/Tetris.jl)
[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/djsegal/tetris-binder/master?urlpath=apps%2FJulia%20Tetris.ipynb)

-----

### 


note: must be using Python 2.x // :(

1) add tetris package

```julia
> Pkg.add("Tetris")
```

2) get webio working

   + see webio [readme](https://github.com/juliaGizmos/WebIO.jl#getting-started) 

3) play some tetris!

```julia
using Tetris

@tetris slow_function()

# or just Tetris.setup()
```

*// for the most part, controls match [tetris friends](http://www.tetrisfriends.com/help/tips_appendix.php#controls)*
