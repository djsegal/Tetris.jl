function Game()
  cur_game = Game(Player[])

  cur_game
end

function Player(cur_game::AbstractGame=Game())
  cur_player = Player(
    cur_game,
    Nullable{AbstractGrid}(),
    Nullable{AbstractBag}(),
    Nullable{AbstractPiece}()
  )

  push!(cur_game.players, cur_player)

  Grid(cur_player)
  Bag(cur_player)

  cur_player
end

function Grid(cur_player::AbstractPlayer=Player())
  cur_grid = Grid(cur_player, Piece[])

  cur_player.grid = cur_grid

  cur_grid
end

function Bag(cur_player::AbstractPlayer=Player())
  cur_bag = Bag(cur_player, Piece[])

  cur_player.bag = cur_bag

  cur_bag
end

function Piece(cur_grid::AbstractGrid=Grid())
  cur_piece = Piece(cur_grid, Block[])

  push!(cur_grid.pieces, cur_piece)

  cur_piece
end

function Block(cur_piece::AbstractPiece=Piece())
  cur_block = Block(cur_piece)

  push!(cur_piece.blocks, cur_block)

  cur_block
end
