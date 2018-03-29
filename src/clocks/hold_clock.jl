function hold_clock(cur_player::AbstractPlayer, cur_uuid::Base.Random.UUID)

  ( cur_player.game.in_focus ) || return

  @async while check_clock(cur_player, :hold, cur_uuid)

    cur_action = getfield(
      Tetris,
      Symbol(cur_player.action)
    )

    cur_action(cur_player)

    sleep(0.09)

  end

end
