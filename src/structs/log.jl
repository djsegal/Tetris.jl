mutable struct Log <: AbstractLog
  label::AbstractString
  value::Int

  score::Int

  level::Int

  lines::Int
  combo::Int

  stash::Int
  glues::Int
  total::Int

  timestamp::DateTime
end

function Log(varargs...)
  cur_log = Log(
    varargs...,
    now()
  )

  cur_log
end
