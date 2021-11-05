{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
  nixpkgs-update = import (import ./nix/sources.nix).nixpkgs-update {};
in
{
  home.packages = with pkgs; [

    fira
    fira-mono
    editorconfig-core-c
    jetbrains-mono
    font-awesome
    any-nix-shell
    asciinema
    bat
    cachix
    dateutils
    evince
    exa
    expect
    fd
    gnupg
    ghc
    htop
    hub
    helix
    imagemagick
    inkscape
    jq
    kak-lsp
    killall
    libsecret
    lshw
    macchina
    niv
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nix-prefetch-github
    nixpkgs-update
    nnn
    pciutils
    q-text-as-data
    remarshal
    ripgrep
    sd
    spotify
    stdenv
    tmate
    tmux
    tree
    usbutils
    duf
    zsh-history-substring-search
    zsh-syntax-highlighting
  ] ++ (with gitAndTools; [
    gh
    git-absorb
    # git-change-author
    git-gone
    git-open
    git-recent
    git-standup
    git-test
    git-fame
  ]);
}
