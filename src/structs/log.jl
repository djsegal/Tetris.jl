mutable struct Log <: AbstractLog
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

  piece::Char
end
