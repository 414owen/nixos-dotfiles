{ home, ... }:

{
    home.file.".gdbinit".text = ''
       set print demangle
       focus next
    '';
}
