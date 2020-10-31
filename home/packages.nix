{ pkgs, ... }:

let
  lib = pkgs.lib;
  unstable = import <unstable> {};
  obelisk = import (builtins.fetchTarball "https://github.com/obsidiansystems/obelisk/archive/master.tar.gz") {};
in
{
  home.packages = with pkgs; [
    any-nix-shell
    asciinema
    bat
    discord
    cabal2nix
    cachix
    cabal-install
    calibre
    darktable
    unstable.ungoogled-chromium
    electrum
    unstable.duf
    exa
    fasd
    fd
    firefox
    unstable.ghc
    gimp
    gnumeric
    gnome3.geary
    gnome3.gnome-tweaks
    gnupg
    q-text-as-data
    unstable.haskell.packages.ghc865.haskell-language-server
    htop
    gitAndTools.hub
    imagemagick
    unstable.haskellPackages.implicit-hie
    # unstable.ib-tws
    inkscape
    jq
    kak-lsp
    killall
    libsecret
    lshw
    mpv-with-scripts
    multimc
    (netsurf.browser.override { uilib = "gtk"; })
    neofetch
    vapoursynth
    vapoursynth-mvtools
    nix-prefetch-github
    nix-index
    nixops
    nix-prefetch-git
    niv
    obelisk.command
    pciutils
    pidgin
    pidgin-window-merge
    purple-hangouts
    ranger
    rawtherapee
    (unstable.haskell.lib.dontCheck unstable.haskellPackages.retrie)
    ripgrep
    sd
    shotwell
    spotify
    stdenv
    st
    tmux
    tor-browser-bundle-bin
    transmission-gtk
    wtf
    xsel
    unstable.zoom-us
    zsh-history-substring-search
    zsh-syntax-highlighting
  ] ++ (with gitAndTools; [
    gh
    git-absorb
    git-gone
    git-open
    git-recent
    git-standup
    git-test
    git-fame
  ]);
}
