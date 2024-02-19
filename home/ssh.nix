{ lib, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "pi" = {
        hostname = "192.168.1.26";
        user = "dietpi";
      };
      "bsd" = {
        hostname = "192.168.1.36";
        user = "owen";
        setEnv = {
          TERM = "xterm-256color";
        };
      };
      "gitlab.internal.tiko.ch" = {
        user = "owen.shepherd@tiko.energy";
        identityFile = "~/.ssh/id_ed";
      };
    };
  };
}
