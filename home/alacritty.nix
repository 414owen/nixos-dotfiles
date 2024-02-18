{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.option_as_alt = "OnlyLeft";
    };
  };
}
