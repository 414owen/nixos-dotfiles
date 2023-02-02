{ config, lib, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).system;
  callPackage = pkgs.callPackage; 
  enableZsh = { enable = true; enableZshIntegration = true; };
in

{
  imports = [
    # ./bash.nix
    ./direnv.nix
    # ./emacs.nix
    ./firefox.nix
    ./fnott.nix
    ./foot.nix
    # ./gdb.nix
    ./ghci.nix
    ./git.nix
    ./theme.nix
    ./helix.nix
    ./gpg-agent.nix
    ./haskeline.nix
    # ./nushell.nix
    ./packages.nix
    # ./nix.nix
    # ./profile.nix
    ./readline.nix
    ./ssh.nix
    ./starship.nix
    ./sway.nix
    ./waybar.nix
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
    stateVersion = "22.11";
    keyboard = {
      layout = "gb";
      options = [
        "ctrl:swapcaps"
      ];
    };
  };

  programs = {
    command-not-found.enable = true;
    direnv.enable = true;
    firefox.enable = true;
    git.enable = true;
    fzf = enableZsh;
    home-manager = {
      enable = true;
      # nixpkgs = { inherit (config.nixpkgs) config overlays; };
    };
    kakoune.enable = true;
    readline.enable = true;
    ssh.enable = true;
    taskwarrior.enable = true;
    tmux.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
