{ config, pkgs, ... }:
let unstable = import <unstable> { config.allowUnfree = true; };
in
{
  imports = [ ./hardware-configuration.nix ./paper-server.nix];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;
  networking.hostName = "vps";
  services.openssh.enable = true;
  system.stateVersion = "20.03";
  programs.zsh.enable = true;
  programs.command-not-found.enable = true;
  nixpkgs.config.allowUnfree = true;

  services.paper-server = {
    enable = true;
    eula = true;
    # jvmOpts = "-Xms3G -Xmx3G ";0server
    jvmOpts = "-Xms3G -Xmx3G -server -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true";
    openFirewall = true;
    serverProperties = {
      motd = "frend!";
      white-list = false;
      view-distance = 8;
    };
    whitelist = {
      Killgarragh = "4bd40a3b-5208-4fff-b3c4-831e832bd99a";
      J00000000NA = "cb6cd158-1305-4e5e-9d8f-67e73f6e3c64";
      "414owen" = "cbed8428-13d5-4d1b-b9c7-725d2ee5ba44";
    };
    bukkitConfig = {
      spawn-limits = {
        monsters = 50;
        animals = 8;
        water-animals = 3;
        ambient = 2;
      };
      chunk-gc = {
        "period-in-ticks" = 400;
        load-threshold = 4;
      };
      ticks-per = {
        monster-spawns = 4;
      };
    };
    spigotConfig = {
      world-settings = {
        default = {
          mob-spawn-range = 6;
          entity-activation-range = {
            animals = 16;
            monsters = 24;
            raiders = 48;
            misc = 8;
          };
          tick-inactive-villagers = false;
          merge-radius = {
            item = 4;
            exp = 6;
          };
          arrow-despawn-rate = 300;
        };
      };
    };
    paperConfig = {
      world-settings = {
        default = {
          max-auto-save-chunks-per-tick = 6;
          optimize-explosions = true;
          mob-spawner-tick-rate = 2;
          disable-chest-cat-detection = true;
          container-update-tick-rate = 3;
          max-entity-collisions = 2;
          grass-spread-tick-rate = 8;
          despawn-ranges = {
            soft = 28;
            hard = 96;
          };
          hopper = {
            disable-move-event = true;
          };
          non-player-arrow-despawn-rate = 3;
          prevent-moving-into-unloaded-chunks = true;
          use-faster-eigencraft-redstone = true;
          armor-stands-tick = false;
          per-player-mob-spawns = true;
        };
      };
    };
  };

  programs.mosh.enable = true;

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = "/run/current-system/sw/bin/zsh";
  };
}

