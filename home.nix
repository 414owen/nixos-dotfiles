{ config, lib, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).system;
  callPackage = pkgs.callPackage;
  enableZsh = { enable = true; enableZshIntegration = true; };
in

{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./dircolors.nix
    ./firefox.nix
    ./ghci.nix
    ./git.nix
    ./theme.nix
    ./gpg-agent.nix
    ./haskeline.nix
    ./kak-lsp.nix
    ./kakoune.nix
    ./packages.nix
    # ./profile.nix
    ./readline.nix
    ./ssh.nix
    ./starship.nix
    # ./sway.nix
    ./taskwarrior.nix
    ./theme.nix
    ./tmux.nix
    # ./zoom.nix
    ./zoxide.nix
    ./zsh.nix
  ];


  home = {
    username = "owen";
    homeDirectory = "/home/owen";
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    stateVersion = "21.05";
    keyboard = {
      layout = "gb";
      options = [
        "ctrl:swapcaps"
      ];
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    alacritty.enable = true;
    command-not-found.enable = true;
    direnv.enable = true;
    dircolors = enableZsh;
    firefox.enable = true;
    fzf = enableZsh;
    git.enable = true;
    home-manager.enable = true;
    kakoune.enable = true;
    readline.enable = true;
    starship.enable = true;
    ssh.enable = true;
    taskwarrior.enable = true;
    tmux.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };

  # wayland.windowManager.sway.enable = true;
}
