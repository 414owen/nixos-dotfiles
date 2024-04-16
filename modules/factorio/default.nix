{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ((factorio.override {
      username = "414owen";
      token = "eaf62803fd09cbdd27d1128a9987c4";
      versionsJson = ./versions.json;
    }))
  ];
}
