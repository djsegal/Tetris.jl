function raw_terminal(f, terminal=terminal, hide_cursor=true)
  cur_enabled = _enable_raw_terminal(terminal)

  hide_cursor &= cur_enabled

  hide_cursor && _cursor_hide(terminal.out_stream)

  try
    f()
  finally
    cur_enabled && _disable_raw_terminal(terminal)
    hide_cursor && _cursor_show(terminal.out_stream)
  end
end

function _enable_raw_terminal(terminal)
  try
    Base.REPL.Terminals.raw!(terminal, true)
    return true
  catch err
    warn("TerminalMenus: Unable to enable raw mode: $err")
  end

  false
end

function _disable_raw_terminal(terminal)
  try
    Base.REPL.Terminals.raw!(terminal, false)
    return true
  catch err
    warn("TerminalMenus: Unable to disable raw mode: $err")
  end

  false
end

_cursor_hide(cur_buffer::IO=STDOUT) = print(cur_buffer, "\x1b[?25l")
_cursor_show(cur_buffer::IO=STDOUT) = print(cur_buffer, "\x1b[?25h")
