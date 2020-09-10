{ lib, ... }:

{
  programs.ssh = {
    matchBlocks = {
      "vps" = {
        hostname = "185.164.136.123";
        user = "owen";
      };
    };
  };
}
