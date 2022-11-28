{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    any-nix-shell
    audio-recorder
    prismlauncher
    asciinema
    bat
    chromium
    choose
      libreoffice
    cabal2nix
    # cabal-install
    cachix
    coreutils
    dateutils
    editorconfig-core-c
    helix
    fira
    fira-code
    font-awesome
    gnome.devhelp
    evince
    spot
    spotify
    exa
    expect
    file
    fd
    gnupg
    gnomeExtensions.system-monitor
    # ghc
    htop
    gnumake
    cgdb
    gimp
    gitAndTools.hub
    htop
    imagemagick
    inkscape
    jq
    killall
    libsecret
    # libreoffice-fresh
    gotop
    lshw
    macchina
    mosh
    mpv
    neofetch
    nix-bundle
    nnn
    niv
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nix-prefetch-github
    nnn
    pciutils
    pidgin
    q-text-as-data
    remarshal
    ripgrep
    sd
    stdenv
    xclip
    scripts.copy
    scripts.vpn
    signal-desktop
    wl-clipboard
    tup
    tree
    transmission-gtk
    tmux
    tree
    usbutils
    vlc
    duf
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
    steam
  ]);
}
