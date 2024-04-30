{
  services.skhd = {
    enable = false;
    skhdConfig = builtins.readFile ./skhdrc;
  };
}
