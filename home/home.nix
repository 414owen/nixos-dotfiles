{ config, lib, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).system;
  callPackage = pkgs.callPackage;
in

{
  imports = [
    ./direnv.nix
    # ./dconf.nix
    ./firefox.nix
    ./ghci.nix
    ./git.nix
    ./gpg-agent.nix
    ./haskeline.nix
    ./kak-lsp.nix
    ./kakoune.nix
    ./packages.nix
    ./readline.nix
    ./ssh.nix
    ./starship.nix
    ./taskwarrior.nix
    ./theme.nix
    ./tmux.nix
    ./zoom.nix
    ./zoxide.nix
    ./zsh.nix
  ];


  home = {
    username = "owen";
    homeDirectory = "/home/owen";
    stateVersion = "20.09";
  };

  programs = {
    command-not-found.enable = true;
    direnv.enable = true;
    firefox.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
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

  services.lorri.enable = true;
}
