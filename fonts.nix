{ pkgs, ... }:

{
 fonts.fonts = with pkgs; [
   noto-fonts
   noto-fonts-emoji
   liberation_ttf
   fira
   fira-code
   fira-code-symbols
   ubuntu_font_family
   roboto
   inconsolata
   cascadia-code
   hermit
   iosevka
   jost
   # monoid
   montserrat
   mononoki
   pecita
   overpass
 ];
}
