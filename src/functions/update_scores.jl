function update_scores(cur_player::AbstractPlayer)
  cur_board = Board()

  cur_player.game.board = cur_board

  cur_js = """
    var curBoardName, curBoardScore;
  """

  for (cur_index, cur_entry) in enumerate(cur_board.entries)
    cur_name = "$(rpad(cur_entry.name, 8, "\u00A0"))"[1:8]
    cur_score = "$(lpad(cur_entry.score, 8, "0"))"[1:8]

    cur_js *= """
      curBoardName = \$(".cs-jumbotron table tr:nth-child($(cur_index)) td:nth-child(2)");
      curBoardScore = \$(".cs-jumbotron table tr:nth-child($(cur_index)) td:nth-child(4)");

      curBoardName.text("$(cur_name)");
      curBoardScore.text("$(cur_score)");
    """
  end

  tetris_js(
    cur_player.game.scope,
    JSString(cur_js)
  )
end
