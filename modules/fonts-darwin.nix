{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = ["FiraMono"]; })
      dejavu_fonts
    ];
  };
}
