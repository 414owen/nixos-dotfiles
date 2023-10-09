{ home, ... }:

{
  home.file.".gdbinit".text = ''
     set print demangle
     focus next
     set history filename /home/owen/.gdb_history
     set history save on
     set history size 1024
     set history remove-duplicates unlimited
  '';
}
