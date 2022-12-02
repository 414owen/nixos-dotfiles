{ pkgs, ... }:

let
  aliases = import ./aliases.nix { pkgs = pkgs; };
  profile = false;
in

{
  programs.zsh = {
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = false;
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

      # Only refresh completions once a day
      setopt extendedglob
      autoload -Uz compinit
      compinit -C
      # for dump in ~/.zcompdump(N.mh+24); do
      #   compinit
      # done
      # compinit -C
    '';
    initExtra = ''
      . ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ${builtins.readFile (./shell.sh)}
      ${import ./fns.nix { pkgs = pkgs; }}
      ${ if profile then "zprof" else "" }
      source <(carapace _carapace)
    '';
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    shellAliases = aliases;
  };
}
