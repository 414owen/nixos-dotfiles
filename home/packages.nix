{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
  sources = import ./nix/sources.nix;
  nixpkgs-update = import sources.nixpkgs-update {};
in
{
  home.packages = with pkgs; [
    any-nix-shell
    asciinema
    bat
    # (retroarch.override { cores = with libretro; [ snes9x ]; })
    chromium
    choose
    cabal2nix
    cabal-install
    cachix
    calibre
    coreutils
    darktable
    dateutils
    editorconfig-core-c
    expect
    pidgin
    fira
    fira-mono
    font-awesome
    gnome.devhelp
    jetbrains-mono
    evince
    # spot
    exa
    expect
    file
    signal-desktop
    fd
    ghc
    htop
    hub
    gnumake
    gdb
    ghc
    gimp
    gitAndTools.hub
    gnome3.geary
    gnumeric
    gnupg
    gparted
    nixpkgs-update
    helix
    htop
    imagemagick
    inkscape
    jq
    kak-lsp
    killall
    libsecret
    lshw
    macchina
    mosh
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
    gotop
    pciutils
    q-text-as-data
    rawtherapee
    remarshal
    ripgrep
    # waveform-pro
    scripts.vpn
    sd
    shotwell
    spotify
    stdenv
    xclip
    scripts.copy
    wl-clipboard
    tree
    tmux
    tree
    transmission-gtk
    usbutils
    duf
    zsh-history-substring-search
    zsh-syntax-highlighting
    # python39
    # python39Packages.pip
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
