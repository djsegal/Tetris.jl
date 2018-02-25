function Game()
  cur_game = Game(Player[])

  cur_game
end

function Player(cur_game::AbstractGame=Game())
  cur_player = Player(
    cur_game,
    Nullable{AbstractGrid}(),
    Nullable{AbstractBag}(),
    Nullable{AbstractPiece}(),
    false
  )

  push!(cur_game.players, cur_player)

  Grid(cur_player)
  Bag(cur_player)

  cur_player
end

function Grid(cur_player::AbstractPlayer=Player())
  cur_rows = 20
  cur_hidden_rows = 2
  cur_cols = 10

  cur_grid = Grid(
    cur_player,
    Piece[],
    cur_rows,
    cur_cols,
    cur_hidden_rows,
    zeros(
      Bool,
      cur_rows + cur_hidden_rows,
      cur_cols
    )
  )

  cur_player.grid = cur_grid

  cur_grid
end

function Bag(cur_player::AbstractPlayer=Player())
  cur_bag = Bag(cur_player, Piece[])

  cur_player.bag = cur_bag

  cur_bag
end
