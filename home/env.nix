{ pkgs, ... }:

let
  defaults = import ./defaults.nix;
  find = defaults.find;
  fzf-command = "fd -t f -c always";
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
  MAKEFLAGS = "-j$(${if pkgs.stdenv.isDarwin then "sysctl -n hw.logicalcpu" else "nproc"})";
  TERMINAL = "${pkgs.st}/bin/st";
  LIBVIRT_DEFAULT_URI = "qemu:///system";
}
