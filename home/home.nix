# TODO rename this midule, or get rid of it.
{ config, lib, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).system;
  callPackage = pkgs.callPackage;
  enableZsh = { enable = true; enableZshIntegration = true; };
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users" else "/home";
in

{
  home.packages = with pkgs; [
    any-nix-shell
  ];

  # TODO reenable
  manual.manpages.enable = false;

  home = {
    username = "owen";
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    homeDirectory = "${homeDirectory}/owen";
    keyboard = {
      layout = "gb";
      options = [
        "ctrl:swapcaps"
      ];
    };
  };

  programs = {
    command-not-found.enable = true;
    dircolors = enableZsh;
    fzf = enableZsh;
    home-manager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
