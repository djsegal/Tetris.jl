is_ijulia() = isdefined(Main, :IJulia) && Main.IJulia.inited
is_juno() = isdefined(Main, :Juno) && Main.Juno.isactive()
is_vscode() = isdefined(Main, :_vscodeserver)

is_ide() = is_ijulia() || is_juno() || is_vscode()
is_repl() = !is_ide()
