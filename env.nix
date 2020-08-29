{ pkgs, ... }:

let
  defaults = import ./defaults.nix;
  find = defaults.find;
  fzf-command = "${pkgs."${find}"}/bin/${find} --type file --color=always";
in

{
  LS_COLORS = "di=33:ow=33:ln=target:ex=35:fi=34";
  EDITOR = defaults.editor;
  AWS_OKTA_BACKEND = "secret-service";
  DOTFILE = "$0";
  FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview '${pkgs.bat}/bin/bat --color=always --style=header,grid --line-range :300 {}'";
  FZF_DEFAULT_COMMAND = "${fzf-command}";
  FZF_CTRL_T_COMMAND = "${fzf-command}";
  FZF_CTRL_R_OPTS = "--preview='' --preview-window 'right:0%'";
  MAKEFLAGS = "-j$(nproc)";
}
