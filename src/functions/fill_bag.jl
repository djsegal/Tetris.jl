function fill_bag!(cur_bag::AbstractBag)

  cur_bag_chars = shuffle(Tetris.tetrominoes)

  for cur_char in cur_bag_chars
    make_piece!(cur_bag, cur_char)
  end

end
