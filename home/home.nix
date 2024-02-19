{homeDirectory, stateVersion}: { config, lib, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).system;
  callPackage = pkgs.callPackage;
  enableZsh = { enable = true; enableZshIntegration = true; };
in

{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./ghci.nix
    ./git.nix
    ./gpg.nix
    ./haskeline.nix
    ./helix.nix
    ./packages.nix
    ./readline.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./tiko.nix
    ./zoxide.nix
    ./zsh.nix
  ] ++ if pkgs.stdenv.isLinux [
    ./firefox.nix
    ./foot.nix
    ./theme.nix
    ./gdb.nix
    ./gpg-agent.nix
  ];

  home.packages = with pkgs; [
    any-nix-shell
  ];

  # TODO reenable
  manual.manpages.enable = false;

  home = {
    username = "owen";
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    homeDirectory = "${homeDirectory}/owen";
    inherit stateVersion;
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
  targets.darwin.defaults.NSGlobalDomain.AppleLocale = "en_GB";
}
