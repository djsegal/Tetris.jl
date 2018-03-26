struct Replica
  name::Char
  points_attributes::Vector{Point}
end

function Replica(cur_piece::AbstractPiece)
  cur_name = cur_piece.name

  raw_points = map(
    cur_block -> calc_block_coords(cur_block),
    cur_piece.blocks
  )

  cur_points = map(
    raw_point -> Point(raw_point...),
    raw_points
  )

  cur_replica = Replica(
    cur_name,
    cur_points
  )

  cur_replica
end
