{ config, lib, pkgs, ... }:

with lib;

let
  unstable = import <unstable> {};

  cfg = config.services.paper-server;

  # We don't allow eula=false anyways
  eulaFile = builtins.toFile "eula.txt" ''
    # eula.txt managed by NixOS Configuration
    eula=true
  '';

  whitelistFile = pkgs.writeText "whitelist.json"
    (builtins.toJSON
      (mapAttrsToList (n: v: { name = n; uuid = v; }) cfg.whitelist));

  cfgToString = v: if builtins.isBool v then boolToString v else toString v;

  serverPropertiesFile = pkgs.writeText "server.properties" (''
    # server.properties managed by NixOS configuration
  '' + concatStringsSep "\n" (mapAttrsToList
    (n: v: "${n}=${cfgToString v}") cfg.serverProperties));


  # To be able to open the firewall, we need to read out port values in the
  # server properties, but fall back to the defaults when those don't exist.
  # These defaults are from https://minecraft.gamepedia.com/Server.properties#Java_Edition_3
  defaultServerPort = 25565;

  serverPort = cfg.serverProperties.server-port or defaultServerPort;

  rconPort = if cfg.serverProperties.enable-rcon or false
    then cfg.serverProperties."rcon.port" or 25575
    else null;

  queryPort = if cfg.serverProperties.enable-query or false
    then cfg.serverProperties."query.port" or 25565
    else null;

  toYAMLFile = outfile: jsonContent: pkgs.runCommandNoCC outfile
    { nativeBuildInputs = [ pkgs.yq-go ]; }
    "yq r -P ${pkgs.writeText (outfile + ".json") (builtins.toJSON jsonContent)} > $out";

  bukkitYml = toYAMLFile "bukkit.yml" cfg.bukkitConfig;
  spigotYml = toYAMLFile "spigot.yml" cfg.spigotConfig;
  paperYml  = toYAMLFile "paper.yml" cfg.paperConfig;

in {
  options = {
    services.paper-server = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          If enabled, start a Minecraft Server. The server
          data will be loaded from and saved to
          <option>services.paper-server.dataDir</option>.
        '';
      };

      eula = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether you agree to
          <link xlink:href="https://account.mojang.com/documents/minecraft_eula">
          Mojangs EULA</link>. This option must be set to
          <literal>true</literal> to run Minecraft server.
        '';
      };

      dataDir = mkOption {
        type = types.path;
        default = "/var/lib/minecraft";
        description = ''
          Directory to store Minecraft database and other state/data files.
        '';
      };

      openFirewall = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to open ports in the firewall for the server.
        '';
      };

      whitelist = mkOption {
        type = let
          minecraftUUID = types.strMatching
            "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}" // {
              description = "Minecraft UUID";
            };
          in types.attrsOf minecraftUUID;
        default = {};
        description = ''
          Whitelisted players, only has an effect when the whitelist is enabled
          via <option>services.paper-server.serverProperties</option> by
          setting <literal>white-list</literal> to <literal>true</literal>.
          This is a mapping from Minecraft usernames to UUIDs.
          You can use <link xlink:href="https://mcuuid.net/"/> to get a
          Minecraft UUID for a username.
        '';
        example = literalExample ''
          {
            username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
            username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
          };
        '';
      };

      serverProperties = mkOption {
        type = with types; attrsOf (oneOf [ bool int str ]);
        default = {};
        example = literalExample ''
          {
            server-port = 43000;
            difficulty = 3;
            gamemode = 1;
            max-players = 5;
            motd = "NixOS Minecraft server!";
            white-list = true;
            enable-rcon = true;
            "rcon.password" = "hunter2";
          }
        '';
        description = ''
          Minecraft server properties for the server.properties file. See
          <link xlink:href="https://minecraft.gamepedia.com/Server.properties#Java_Edition_3"/>
          for documentation on these values.
        '';
      };

      package = mkOption {
        type = types.package;
        default = import ./paper-package.nix;
        # default = "${import ./paper-package.nix {}}/bin/minecraft-server";
        defaultText = "unstable.papermc";
        description = "Version of paper to run.";
      };

      jvmOpts = mkOption {
        type = types.separatedString " ";
        default = "-Xmx2048M -Xms2048M";
        # Example options from https://minecraft.gamepedia.com/Tutorials/Server_startup_script
        example = "-Xmx2048M -Xms4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing "
          + "-XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 "
          + "-XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
        description = "JVM options for the Minecraft server.";
      };

      bukkitConfig = mkOption {
        type = types.attrs;
        default = {};
        example = literalExample ''
          {
            settings = {
              allow-end = true;
              warn-on-overload = true;
            };
            chunk-gc = {
              period-in-ticks = 600;
            };
          }
        '';
        description = ''
          Bukkit configuration to be written to bukkit.yml.
          See <link xlink:href="https://bukkit.gamepedia.com/Bukkit.yml"/>
          for documentation.
        '';
      };

      spigotConfig = mkOption {
        type = types.attrs;
        default = {};
        example = literalExample ''
          {
            config-version = 11;
            commands = {
              tab-complete = 0;
            };
            world-settings = {
              default = {
                view-distance = 10;
                ticks-per = {
                  hopper-transfer = 8;
                  hopper-check = 1;
                };
              };
            };
          }
        '';
        description = ''
          Spigot configuration to be written to spigot.yml.
          See <link xlink:href="https://www.spigotmc.org/wiki/spigot-configuration/"/>
          for documentation.
        '';
      };

      paperConfig = mkOption {
        type = types.attrs;
        default = {};
        example = literalExample ''
          {
            world-settings = {
              default = {
                max-growth-height = {
                  cactus = 3;
                  reeds = 3;
                };
              };
            };
          }
        '';
        description = ''
          Paper configuration to be written to paper.yml.
          See <link xlink:href="https://paper.readthedocs.io/en/latest/server/configuration.html"/>
          for documentation.
        '';
      };

    };
  };

  config = mkIf cfg.enable {

    users.users.minecraft = {
      description     = "Minecraft server service user";
      home            = cfg.dataDir;
      createHome      = true;
      uid             = config.ids.uids.minecraft;
    };

    systemd.services.paper-server = {
      description   = "Minecraft Server Service";
      wantedBy      = [ "multi-user.target" ];
      after         = [ "network.target" ];

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/minecraft-server ${cfg.jvmOpts}";
        Restart = "always";
        User = "minecraft";
        WorkingDirectory = cfg.dataDir;
      };

      preStart = ''
        ln -sf ${eulaFile} eula.txt
        ln -sf ${whitelistFile} whitelist.json
        ln -sf ${bukkitYml} bukkit.yml
        ln -sf ${spigotYml} spigot.yml
        ln -sf ${paperYml} paper.yml
        cp -b ${serverPropertiesFile} server.properties
        # server.properties must have write permissions, because every time
        # the server starts it first parses the file and then regenerates it..
        chmod +w server.properties
      '';
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedUDPPorts = [ serverPort ];
      allowedTCPPorts = [ serverPort ]
        ++ optional (queryPort != null) queryPort
        ++ optional (rconPort != null) rconPort;
    };

    assertions = [
      { assertion = cfg.eula;
        message = "You must agree to Mojangs EULA to run paper-server."
          + " Read https://account.mojang.com/documents/minecraft_eula and"
          + " set `services.paper-server.eula` to `true` if you agree.";
      }
    ];

  };
}
