{ config, lib, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).system;
  utdemir = builtins.fetchGit {
    url = https://github.com/utdemir/dotfiles.git;
    rev = "ce5205f03b03872a9032b5b15d7f2b417bfd3dec";
  };
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
    ./starship.nix
    ./wtf.nix
    ./theme.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.stateVersion = "20.03";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball https://github.com/nix-community/NUR/archive/master.tar.gz) {
          inherit pkgs;
        };
        haskellPackages = pkgs.haskellPackages.override {
          overrides = hself: hsuper: { };
        };
        mpv = pkgs.mpv.override {
          vapoursynthSupport = true;
        };
        kakoune = (pkgs.kakoune.override {
          configure = {
            plugins = with pkgs.kakounePlugins; [
              (callPackage "${utdemir}/packages/kakoune-surround.nix" { })
              (callPackage "${utdemir}/packages/kakoune-rainbow.nix" { })
              kak-auto-pairs
              kak-fzf
              pkgs.kak-lsp
            ];
          };
        });
      };
    };
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
    tmux.enable = true;
    zsh.enable = true;
  };

  services.lorri.enable = true;
}
