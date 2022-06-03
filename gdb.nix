{ home, ... }:

let
    dlang = (import ./nix/sources.nix).dlang-debug;
in

{
    home.file.".gdbinit".text = ''
       enable pretty-printer
       set print demangle
       focus next
       tui disable
    '';
}
