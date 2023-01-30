{ pkgs, ... }:

let
  aliases = import ./aliases.nix { pkgs = pkgs; };
  profile = false;
in

{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = false;
    enableCompletion = true;
    history = {
      ignoreDups = true;
      share = true;
    };
    initExtraBeforeCompInit = ''
      ${ if profile then "zmodload zsh/zprof" else "" }

      # if [ "$TERM" = "alacritty" ]; then
      #   if [ -z "$TMUX" ]; then
      #     tmux
      #     exit
      #   fi
      # fi
    '';
    initExtra = ''
      . ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ${builtins.readFile (./shell.sh)}
      ${import ./fns.nix { pkgs = pkgs; }}
      ${ if profile then "zprof" else "" }
    '';
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    shellAliases = aliases;
  };
}
