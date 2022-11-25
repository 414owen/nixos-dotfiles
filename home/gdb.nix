{ home, ... }:

{
    home.file.".gdbinit".text = ''
       set print demangle
       set history save
       focus next
    '';
}
