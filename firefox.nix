{ pkgs, home, ... }:

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

  # adwaita theme
  # home.file.".mozilla/firefox/default/chrome" = {
  #   recursive = false;
  #   source = builtins.fetchGit {
  #     url = "https://github.com/414owen/firefox-gnome-theme.git";
  #     rev = "32b51bab0d621469218cdb5f5116137de3da55da";
  #     ref = "fix-webextension-background";
  #   };
  # };

  programs.firefox = {
    package = pkgs.firefox-wayland;
    profiles = {
      default = {
        settings = {
          # "app.shield.optoutstudies.enabled" = false;
          # "browser.bookmarks.showMobileBookmarks" = true;
          # # "browser.contentblocking.category" = "strict";
          # "browser.download.panel.shown" = true;
          # "browser.download.useDownloadDir" = true;
          # "browser.fullscreen.autohide" = true;
          # "browser.safebrowsing.malware.enabled" = false;
          # "browser.safebrowsing.phishing.enabled" = false;
          # "browser.search.geoip.url" = "";
          # "browser.search.isUS" = false;
          # "browser.search.region" = "GB";
          # "browser.send_pings" = false;
          # "browser.startup.page" = 3;
          # "browser.tabs.closeWindowWithLastTab" = true;
          # "browser.tabs.warnOnClose" = false;
          # "devtools.theme" = "dark";
          # "distribution.searchplugins.defaultLocale" = "en-GB";
          # "dom.battery.enabled" = false;
          # "dom.event.clipboardevents.enabled" = false;
          # "experiments.activeExperiment" = false;
          # "experiments.enabled" = false;
          # "experiments.supported" = false;
          # "extensions.pocket.enabled" = false;
          # "general.useragent.locale" = "en-GB";
          # "geo.enabled" = false;
          # "layout.spellcheckDefault" = 2;
          # "media.navigator.enabled" = false;
          # "privacy.firstparty.isolate" = true;
          # "privacy.resistFingerprinting" = true;
          # "privacy.trackingprotection.cryptomining.enabled" = true;
          # "privacy.trackingprotection.enabled" = true;
          # "privacy.trackingprotection.fingerprinting.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # "toolkit.telemetry.enabled" = false;
          "view_source.editor.args" = "${pkgs.gnome3.gnome-terminal}/bin/gnome-terminal ${(import ./defaults.nix).editor}";
          "view_source.editor.external" = true;
          "view_source.editor.path" = "${viewSource}/bin/view-source";

          "gnomeTheme.hideSingleTab" = true;
          "gnomeTheme.systemIcons" = false;
          "gnomeTheme.symbolicTabIcons" = true;
        };
      };
    };
  };
}
