{ pkgs, home, betterfox, ... }:

let
  viewSource = pkgs.writeTextFile {
    name = "view-firefox-source-script";
    destination = "/bin/view-source";
    executable = true;
    text = ''
      #!/usr/bin/env sh

      # rename, so we get filetype detection
      mv "$3" "$3.html"
      $1 -e "$2 \"$3.html\""
    '';
  };
in {

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      default = {
        extraConfig = builtins.readFile "${betterfox}/user.js";
        settings = {
          "media.autoplay.default" = 5; # block all
          "browser.startup.page" = 0; # blank
          "browser.aboutConfig.showWarning" = false;
          "browser.translations.neverTranslateLanguages" = "fr";
          "browser.tabs.crashReporting.sendReport" = false;
          "accessibility.typeaheadfind.enablesound" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "browser.send_pings" = false;

          # Opt out of AB testing
          "app.normandy.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;

          # bluetooth location BS
          "beacon.enabled" = false;
          "device.sensors.enabled" = false; # This isn't a phone
          # "geo.enabled" = false; # Disable geolocation alltogether

          # ESNI is deprecated ECH is recommended
          "network.dns.echconfig.enabled" = true;

          # Disable telemetry not covered by betterfox
          "extensions.webcompat-reporter.enabled" = false; # don't report compability problems to mozilla
          "datareporting.healthreport.uploadEnabled" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.urlbar.eventTelemetry.enabled" = false;

          "extensions.abuseReport.enabled" = false; # don't show 'report abuse' in extensions
          "browser.contentblocking.report.lockwise.enabled" = false; # don't use firefox password manger
          "browser.uitour.enabled" = false; # no tutorial please
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          # disable EME encrypted media extension (Providers can get DRM
          # through this if they include a decryption black-box program)
          "browser.eme.ui.enabled" = false;
          "media.eme.enabled" = false;

          # don't predict network requests
          "network.predictor.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;

          # disable annoying web features
          "dom.push.enabled" = false; # no notifications, really...
          "dom.push.connection.enabled" = false;
          "dom.battery.enabled" = false; # you don't need to see my battery...

          # disable builtin pdf viewer
          "pdfjs.disabled" = true;
          "pdfjs.enableScripting" = false;

          "browser.tabs.searchclipboardfor.middleclick" = false;

          "browser.download.manager.addToRecentDocs" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
        };

        search = {
          force = true;
          order = ["Google" "DuckDuckGo" "Youtube" "NixOS Options" "Nix Packages" "GitHub" "HackerNews"];

          engines = {
            "Bing".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Google".metaData.hidden = false;

            "Kagi" = {
              iconUpdateURL = "https://kagi.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@k"];
              urls = [
                {
                  template = "https://kagi.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "YouTube" = {
              iconUpdateURL = "https://youtube.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@yt"];
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "Nix Packages" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "NixOS Options" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "GitHub" = {
              iconUpdateURL = "https://github.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@gh"];

              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "Home Manager" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@hm"];

              url = [
                {
                  template = "https://mipmip.github.io/home-manager-option-search/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "HackerNews" = {
              iconUpdateURL = "https://hn.algolia.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@hn"];

              url = [
                {
                  template = "https://hn.algolia.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
          };
        };
      };
    };
  };
}
