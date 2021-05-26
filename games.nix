{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ steam ];

  # fps games on laptop need this
  services.xserver.libinput.disableWhileTyping = false;

  # 32-bit support needed for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # better for steam proton games
  systemd.extraConfig = "DefaultLimitNOFILE=1048576";

  # improve wine performance
  environment.sessionVariables = {
    WINEDEBUG = "-all";
  };
}
