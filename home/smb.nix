{ pkgs, home, ... }:

{
  home.file.".smbcredentials".text = ''
    username=oshepherd_sym
    password=Tsinacota1s
  '';
}
