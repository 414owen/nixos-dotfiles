{ config, lib, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).system;
  callPackage = pkgs.callPackage;
in

{
  imports = [
    ./dconf.nix
    ./direnv.nix
    ./firefox.nix
    ./git.nix
    ./gpg-agent.nix
    ./kak-lsp.nix
    ./kakoune.nix
    ./packages.nix
    ./readline.nix
    ./ssh.nix
    ./starship.nix
    ./wtf.nix
    ./theme.nix
    ./tmux.nix
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
    tmux.enable = true;
    zsh.enable = true;
  };

  services.lorri.enable = true;
}
