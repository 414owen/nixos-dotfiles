{ pkgs, ... }:

let
  lib = pkgs.lib;
  unstable = import <unstable> { config = { allowUnfree = true; }; };
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
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
    darktable
    discord
    exa
    fasd
    unstable.feeds
    signal-desktop
    fd
    ghc
    gimp
    gitAndTools.hub
    gnome3.geary
    gnome3.gnome-tweaks
    gnumeric
    gnupg
    gparted
    haskell.packages.ghc865.haskell-language-server
    haskellPackages.implicit-hie
    haskellPackages.retrie
    htop
    # (ib-tws.override (old: {
    #   jdk = openjdk;
    # }))
    imagemagick
    inkscape
    jq
    kak-lsp
    killall
    libsecret
    lshw
    mpv
    multimc
    neofetch
    (netsurf.browser.override { uilib = "gtk"; })
    non
    niv
    nix-index
    nix-prefetch-git
    nix-prefetch-github
    pciutils
    (pidgin.override {
      plugins = [
        pidgin-window-merge
        purple-hangouts
        telegram-purple
      ];
    })
    q-text-as-data
    ranger
    rawtherapee
    remarshal
    ripgrep
    waveform-pro
    sd
    shotwell
    spotify
    st
    stdenv
    tmux
    transmission-gtk
    usbutils
    unstable.duf
    xsel
    zoom-us
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
