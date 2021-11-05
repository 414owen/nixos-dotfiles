{ pkgs, ... }:

let
  defaults = import ./defaults.nix;
  find = defaults.find;
  fzf-command = "${pkgs."${find}"}/bin/${find} --type file --color=always";
in

{
  AWS_OKTA_BACKEND = "secret-service";
  CDPATH = ".:~/src";
  DOTFILE = "$0";
  EDITOR = defaults.editor;
  FZF_CTRL_R_OPTS = "--preview='' --preview-window 'right:0%'";
  FZF_CTRL_T_COMMAND = "${fzf-command}";
  FZF_DEFAULT_COMMAND = "${fzf-command}";
  FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview '${pkgs.bat}/bin/bat --color=always --style=header,grid --line-range :300 {}'";
  MAKEFLAGS = "-j$(nproc)";
  TERMINAL = "${pkgs.st}/bin/st";
  # force all generic backend to use wayland backend
  # GDK_BACKEND = "wayland";
  # QT_QPA_PLATFORM = "wayland-egl";
  # CLUTTER_BACKEND = "wayland";
  # SDL_VIDEODRIVER = "wayland";
  # EWOL_BACKEND = "wayland";
  #
  # XCURSOR_THEME = "Quogir-dark";
}
