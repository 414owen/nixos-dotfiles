{ pkgs, home, ... }:

let
  tree-sitter = (import ./nix/sources.nix).elisp-tree-sitter;
in

{
  services.emacs.package = pkgs.emacsGcc;
  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = (epkgs: with epkgs; [
      all-the-icons
      doom-themes
      ivy
      counsel
      dashboard
      swiper
      magit
      meow
      nix-mode
      page-break-lines
      projectile
      rust-mode
      tree-sitter
      tree-sitter-langs
      use-package
      which-key
    ]);
  };

  home.file.".emacs.el" = {
    text = ''
      ${builtins.readFile ./emacs.el}
      (add-to-list 'load-path "${tree-sitter}/core")
      (add-to-list 'load-path "${tree-sitter}/lisp")
      (add-to-list 'load-path "${tree-sitter}/langs")

      (setq tsc-dyn-dir (expand-file-name "tree-sitter/" user-emacs-directory))
    '';
  };
}
