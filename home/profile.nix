{ pkgs, ... }:

{
  home.file.".zprofile".text = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/pts/0" ]; then
      exec /bin/sway
    fi
  '';
}
