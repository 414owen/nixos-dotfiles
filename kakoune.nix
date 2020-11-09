{ pkgs, lib, ... }:

let
  # from Ben Kolera's dotfiles https://github.com/benkolera/nix/
  isKakFile = name: type: type == "regular" && lib.hasSuffix ".kak" name;
  isDir     = name: type: type == "directory";
  allKakFiles = (dir: 
    let fullPath = p: "${dir}/${p}";
        files = builtins.readDir dir;
        subdirs  = lib.concatMap (p: allKakFiles (fullPath p)) (lib.attrNames (lib.filterAttrs isDir files));
        subfiles = builtins.map fullPath (lib.attrNames (lib.filterAttrs isKakFile files));
    in (subfiles ++ subdirs)
  );
  kakImport = name: ''source "${name}"'';
  allKakImports = dir: builtins.concatStringsSep "\n" (map kakImport (allKakFiles dir));
  utdemir = (import ./nix/sources.nix).utdemir-dotfiles;
in

{
  programs.kakoune = {
    config = {
      autoInfo = [ "command" "normal" ];
      autoReload = "yes";
      indentWidth = 2;
      keyMappings = [
        { mode = "insert"; key = "<tab>"; effect = "<a-;><gt>"; }
        { mode = "insert"; key = "<s-tab>"; effect = "<a-;><lt>"; }
        { mode = "normal"; key = "'#'"; effect = ":comment-line<ret>"; }
        { mode = "normal"; key = "'<a-#>'"; effect = ":comment-block<ret>"; }
        # I use the default for navigating tmux panes
        { mode = "normal"; key = "<c-j>"; effect = "glEs\\s<ret>d"; }
        { mode = "normal"; key = "<c-J>"; effect = "<a-J>"; }
        { mode = "goto"; key = "m"; effect = "<esc>m;"; }
        { mode = "normal"; key = "<c-p>"; effect = ":fzf-mode<ret>"; }
      ];
      numberLines = {
        enable = true;
        highlightCursor = true;
        relative = true;
        separator = "|";
      };
      scrollOff.lines = 10;
      showMatching = true;
      showWhitespace.enable = false;
      tabStop = 2;
      ui = {
        assistant = "none";
        enableMouse = true;
        setTitle = true;
      };
      wrapLines = {
        enable = true;
        indent = true;
        word = true;
        marker = "-";
      };
    };
    extraConfig = ''
      ${builtins.readFile ./config.kak}
      declare-option str gray 'rgb:44475a'
      face global MenuBackground gray
      face global MenuForeground gray
      set-face global PrimarySelection black,white
      set-face global PrimaryCursor black,red
      set-face global SecondarySelection white,black
      set-face global SecondaryCursor black,blue
    '';
    plugins = with pkgs.kakounePlugins; [
      (pkgs.callPackage "${utdemir}/nix/packages/kakoune-surround.nix" { })
      (pkgs.callPackage "${utdemir}/nix/packages/kakoune-rainbow.nix" { })
      kak-auto-pairs
      kak-fzf
      pkgs.kak-lsp
      kakboard
      smarttab
    ];
  };
}
