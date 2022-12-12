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
    coreutils
    editorconfig-core-c
    helix
    fira
    fira-code
    font-awesome
    gnome.devhelp
    evince
    spot
    exa
    expect
    file
    fd
    gnupg
    gnomeExtensions.system-monitor
    htop
    gnumake
    htop
    killall
    libsecret
    lshw
    macchina
    mosh
    mpv
    niv
    nix-output-monitor
    ripgrep
    sd
    stdenv
    xclip
    scripts.copy
    wl-clipboard
    tree
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
  ]);
}
