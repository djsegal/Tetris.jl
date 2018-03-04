function free(cur_player::AbstractPlayer)
  cur_player.action = ""

  cur_player.clock.hold =
    Nullable{Base.Random.UUID}()

  return
end
