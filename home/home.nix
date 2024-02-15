{homeDirectory, stateVersion}: { config, lib, pkgs, ... }:

let
  sysconfig = (import <nixpkgs/nixos> {}).system;
  callPackage = pkgs.callPackage;
  enableZsh = { enable = true; enableZshIntegration = true; };
in

{
  imports = [
    # ./bash.nix
    # ./dconf.nix
    # ./direnv.nix
    # ./firefox.nix
    # ./foot.nix
    # ./gdb.nix
    # ./ghci.nix
    # ./git.nix
    # ./gpg-agent.nix
    ./haskeline.nix
    ./helix.nix
    # ./nushell.nix
    ./packages.nix
    ./readline.nix
    # ./ssh.nix
    ./starship.nix
    # ./sway.nix
    # ./theme.nix
    ./tmux.nix
    # ./waybar.nix
    # ./yambar.nix
    # ./zoom.nix
    ./tiko.nix
    ./zoxide.nix
    ./zsh.nix
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
}
