{ pkgs, home, ... }:

{
  home.file.".config/yambar/config.yml" = {
    recursive = false;
    source = ''
      bar:
        height: 26
        location: top
        background: 000000ff

        right:
          - clock:
              content:
                - string: {text: , font: "Font Awesome 6 Free:style=solid:size=12"}
                - string: {text: "{date}", right-margin: 5}
                - string: {text: , font: "Font Awesome 6 Free:style=solid:size=12"}
                - string: {text: "{time}"}
    '';
  };
}
