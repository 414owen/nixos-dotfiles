{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ((factorio.override {
      username = "414owen";
      token = import ../../secrets/factorio.nix;
      versionsJson = ./versions.json;
    }))
  ];
}
