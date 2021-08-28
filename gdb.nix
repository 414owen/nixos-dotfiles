{ home, ... }:

{
    home.file.".ghci".text = "
       set history save
       tui enable
       focus next
    ";
}
