mutable struct Grid <: AbstractGrid
  player::AbstractPlayer

  rows::Int
  cols::Int

  hidden_rows::Int
  height::Int

  table::Array{AbstractString,2}
end

function Grid(cur_player::AbstractPlayer=Player())
  cur_rows = 20
  cur_cols = 10

  cur_hidden_rows = 2
  cur_height = 0

  cur_grid = Grid(
    cur_player,
    cur_rows,
    cur_cols,
    cur_hidden_rows,
    cur_height,
    fill!(
      Array{AbstractString}(
        cur_rows + cur_hidden_rows,
        cur_cols
      ),
      ""
    )
  )

  cur_player.grid = cur_grid

  cur_grid
end
