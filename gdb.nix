{ home, ... }:

let
    dlang = (import ./nix/sources.nix).dlang-debug;
in

{
    home.file.".gdbinit".text = ''
       enable pretty-printer
       # interpreter-exec console "source ${dlang}/gdb_dlang.py"
       set print demangle
       set history save
       tui enable
       focus next
    '';
}
