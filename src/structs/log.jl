mutable struct Log <: AbstractLog
  replica_attributes::Replica

  position::Int

  label::AbstractString
  value::Int

  score::Int

  level::Int

  lines::Int
  combo::Int

  stash::Int
  glues::Int
  total::Int
end
