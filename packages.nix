{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
  unstable = import <unstable> {};
  sources = import ./nix/sources.nix;
  nixpkgs-update = import sources.nixpkgs-update {};
in
{
  home.packages = with pkgs; [
    any-nix-shell
    asciinema
    bat
    cabal2nix
    cabal-install
    cachix
    calibre
    clang
    coreutils
    darktable
    dateutils
    editorconfig-core-c
    fira
    fira-mono
    font-awesome
    gnome.devhelp
    jetbrains-mono
    evince
    exa
    expect
    file
    signal-desktop
    fd
    gnupg
    ghc
    htop
    hub
    helix
    gnumake
    gdb
    ghc
    gimp
    gitAndTools.hub
    gnome3.geary
    gnome3.gnome-tweaks
    gnumeric
    gnupg
    gparted
    nixpkgs-update
    unstable.helix
    htop
    imagemagick
    inkscape
    jq
    kak-lsp
    killall
    libsecret
    lshw
    macchina
    mpv
    # newsflash
    neofetch
    nix-bundle
    nnn
    non
    niv
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nix-prefetch-github
    nixpkgs-update
    nnn
    pciutils
    (pidgin.override {
      plugins = [
        pidgin-window-merge
        purple-hangouts
        telegram-purple
      ];
    })
    q-text-as-data
    rawtherapee
    remarshal
    ripgrep
    # waveform-pro
    sd
    shotwell
    unstable.spot
    stdenv
    wl-clipboard
    tree
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
    scripts.git-weekend
  ]);
}
