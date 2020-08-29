{ pkgs, ... }:

{
  home.file.".config/wtf/config.yml".text = ''
    wtf:

      colors:
        background: "transparent"
        border:
          focusable: "lightgreen"
          focused: "goldenrod"
          normal: "darkgreen"
        checked: "gray"
        highlight:
          fore: "black"
          back: "green"
        labels: "lightgreen::b"
        rows:
          even: "green"
          odd: "lightgreen"
        subheading: "lightgreen::b"
        text: "green"
        title: "lightgreen"

      # grid:
      #   columns: [13, 7, 20, 20]
      #   rows: [8, 40]

      refreshInterval: 1

      mods:

        # You can have multiple widgets of the same type.
        # The "key" is the name of the widget and the type is the actual
        # widget you want to implement.
        time:
          title: "Time"
          type: clocks
          colors:
            rows:
              even: "lightblue"
              odd: "white"
          enabled: true
          locations:
            Dublin: "Europe/Dublin"
            Ghent: "Europe/Brussels"
            Stockholm: "Europe/Stockholm"
            Boston / NY: "EST"
            Melbourne: "Australia/Melbourne"
          position:
            top: 0
            left: 0
            height: 1
            width: 1
          refreshInterval: 15
          sort: "alphabetical"

        ipinfo:
          colors:
            name: "lightblue"
            value: "white"
          enabled: true
          position:
            top: 1
            left: 0
            height: 1
            width: 1
          refreshInterval: 150

        git:
          commitCount: 5
          commitFormat: "[forestgreen]%h [grey]%cd [white]%s [grey]%an[white]"
          dateFormat: "%H:%M %d %b %y"
          enabled: true
          position:
            top: 2
            left: 0
            height: 1
            width: 2
          refreshInterval: 8
          repositories:
          - "/home/owen/src/hoggles"
          - "/home/owen/src/highway"
          - "/home/owen/src/haskell-language-server"
          - "/home/owen/src/kak-lsp"

        hackernews:
          enabled: true
          title: HN
          numberOfStories: 30
          storytype: top
          position:
            top: 0
            left: 2
            height: 2
            width: 2
          refreshInterval: 900

        feedreader:
          enabled: true
          title: Feeds
          feeds:
            - http://feeds.bbci.co.uk/news/rss.xml
            - https://www.phoronix.com/rss.php
          feedLimit: 8
          position:
            top: 2
            left: 2
            height: 1
            width: 2
          refreshInterval: 900

        resourceusage:
          title: CPU / Mem / Swap
          enabled: true
          position:
            top: 0
            left: 1
            height: 2
            width: 1
          refreshInterval: 1

  '';
}
