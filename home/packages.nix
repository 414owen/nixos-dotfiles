{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
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
    choose
    ungoogled-chromium
    coreutils
    darktable
    dateutils
    duf
    editorconfig-core-c
    evince
    exa
    expect
    expect
    bfs
    file
    fira
    fira-mono
    font-awesome
    gdb
    ghc
    ghc
    gimp
    gitAndTools.hub
    gnome3.geary
    gnome.devhelp
    gnomeExtensions.material-shell
    gnumake
    gnumeric
    gnupg
    gotop
    gparted
    helix
    htop
    htop
    hub
    imagemagick
    inkscape
    jetbrains-mono
    jq
    killall
    libsecret
    lshw
    macchina
    mosh
    mpv
    neofetch
    # newsflash
    niv
    nix-bundle
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nix-prefetch-github
    nnn
    nnn
    non
    pciutils
    pidgin
    prismlauncher
    # python39
    # python39Pack
    q-text-as-data
    rawtherapee
    remarshal
    # (retroarch.override { cores = with libretro; [ snes9x ]; })
    ripgrep
    scripts.copy
    sd
    shotwell
    signal-desktop
    # spot
    spotify
    stdenv
    tmux
    transmission-gtk
    tree
    tree
    usbutils
    wine
    vlc
    # waveform-pro
    wl-clipboard
    xclip
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
