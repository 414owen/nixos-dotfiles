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
    # ./emacs.nix
    ./firefox.nix
    ./foot.nix
    # ./gdb.nix
    ./ghci.nix
    ./git.nix
    ./theme.nix
    ./helix.nix
    ./gpg-agent.nix
    ./haskeline.nix
    ./nushell.nix
    ./packages.nix
    # ./profile.nix
    ./readline.nix
    ./ssh.nix
    ./starship.nix
    ./sway.nix
    ./taskwarrior.nix
    ./theme.nix
    ./tmux.nix
    # ./zoom.nix
    ./waybar.nix
    # ./yambar.nix
    ./zoxide.nix
    ./zsh.nix
  ];


  home = {
    username = "owen";
    homeDirectory = "/home/owen";
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    stateVersion = "22.05";
    keyboard = {
      layout = "gb";
      options = [
        "ctrl:swapcaps"
      ];
    };
  };

  programs = {
    alacritty.enable = true;
    command-not-found.enable = true;
    direnv.enable = true;
    dircolors = enableZsh;
    foot.enable = true;
    firefox.enable = true;
    fzf = enableZsh;
    git.enable = true;
    home-manager.enable = true;
    readline.enable = true;
    starship.enable = true;
    ssh.enable = true;
    taskwarrior.enable = true;
    tmux.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };

  services.udiskie.enable = true;

  nixpkgs.config.allowUnfree = true;
}
