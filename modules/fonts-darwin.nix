{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = ["FiraMono"]; })
      dejavu_fonts
    ];
  };
}
