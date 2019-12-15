function free(cur_player::AbstractPlayer)
  cur_player.action = ""

  cur_player.clock.hold =
    Nullable{UUIDs.UUID}()

  return
end
