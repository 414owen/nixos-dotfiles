{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
  };

  # fps games on laptop need this
  services.xserver.libinput.touchpad.disableWhileTyping = false;

  # better for steam proton games
  systemd.extraConfig = "DefaultLimitNOFILE=1048576";

  # improve wine performance
  environment.sessionVariables = {
    WINEDEBUG = "-all";
  };
}
