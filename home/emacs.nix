{ pkgs, home, ... }:

let
  sources = import ./nix/sources.nix;
  nur = import sources.nur { pkgs = null; };
  tree-sitter = sources.elisp-tree-sitter;
  package = pkgs.emacs;
in



{
  imports = [
    nur.repos.rycee.hmModules.emacs-init
  ];

  programs.emacs = {
    enable = true;
    package = package;
  };

  programs.emacs.init = {
    enable = true;

    packageQuickstart = false;
    recommendedGcSettings = true;
    usePackageVerbose = false;

    earlyInit = ''
      ;; Emacs really shouldn't be displaying anything until it has fully started
      ;; up. This saves a bit of time.
      (setq-default inhibit-redisplay t
                    inhibit-message t)
      (add-hook 'window-setup-hook
                (lambda ()
                  (setq-default inhibit-redisplay nil
                                inhibit-message nil)
                  (redisplay)))

      ;; Disable some GUI distractions. We set these manually to avoid starting
      ;; the corresponding minor modes.
      (push '(menu-bar-lines . 0) default-frame-alist)
      (push '(tool-bar-lines . nil) default-frame-alist)
      (push '(vertical-scroll-bars . nil) default-frame-alist)

      ;; I typically want to use UTF-8.
      (prefer-coding-system 'utf-8-unix)
      (set-language-environment "UTF-8")

      ;; Set up fonts early.
      (set-face-attribute 'default
                          nil
                          :height 80
                          :family "Fantasque Sans Mono")
      (set-face-attribute 'variable-pitch
                          nil
                          :family "DejaVu Sans")

      ;; Please don't load outdated byte code
      (setq load-prefer-newer t)

      ;; Debugging
      (setq message-log-max 10000)

    '';

    prelude = ''
      ;; Disable audio bell
      (setq visible-bell 1)

      ;; Disable startup message.
      (setq inhibit-startup-screen t
            inhibit-startup-echo-area-message (user-login-name))

      (setq initial-major-mode 'fundamental-mode
            initial-scratch-message nil)

      ;; Don't blink the cursor.
      (setq blink-cursor-mode nil)

      ;; Set frame title.
      (setq frame-title-format
            '("" invocation-name ": "(:eval
                                      (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

      ;; Make sure the mouse cursor is visible at all times.
      (set-face-background 'mouse "#ffffff")

      ;; Accept 'y' and 'n' rather than 'yes' and 'no'.
      (defalias 'yes-or-no-p 'y-or-n-p)

      ;; Don't want to move based on visual line.
      (setq line-move-visual nil)

      ;; Stop creating backup and autosave files.
      (setq make-backup-files nil
            auto-save-default nil)

      ;; Default is 4k, which is too low for LSP.
      (setq read-process-output-max (* 1024 1024))

      ;; Always show line and column number in the mode line.
      (line-number-mode)
      (column-number-mode)

      ;; Enable some features that are disabled by default.
      (put 'narrow-to-region 'disabled nil)

      ;; Typically, I only want spaces when pressing the TAB key. I also
      ;; want 4 of them.
      (setq-default indent-tabs-mode nil
                    tab-width 2
                    c-basic-offset 2)

      ;; Trailing white space are banned!
      (setq-default show-trailing-whitespace t)

      ;; Use one space to end sentences.
      (setq sentence-end-double-space nil)

      ;; Nicer handling of regions.
      (transient-mark-mode 1)

      ;; Make moving cursor past bottom only scroll a single line rather
      ;; than half a page.
      (setq scroll-step 1
            scroll-conservatively 5)

      ;; Enable highlighting of current line.
      (global-hl-line-mode 1)

      ;; Improved handling of clipboard in GNU/Linux and otherwise.
      (setq select-enable-clipboard t
            select-enable-primary t
            save-interprogram-paste-before-kill t)

      ;; Pasting with middle click should insert at point, not where the
      ;; click happened.
      (setq mouse-yank-at-point t)

      ;; Enable a few useful commands that are initially disabled.
      (put 'upcase-region 'disabled nil)
      (put 'downcase-region 'disabled nil)

      ;;; Directories
      (defvar user-setup-directory          (expand-file-name "setup"          user-emacs-directory))
      (defvar user-setup-builtins-directory (expand-file-name "setup/builtins" user-emacs-directory))
      (defvar local-dev-package-directory   (expand-file-name "packages"       user-emacs-directory))
      (defvar user-data-directory           (expand-file-name ""               user-emacs-directory))
      (defvar user-cache-directory          (expand-file-name ".cache"         user-emacs-directory))
      (defvar user-bin-directory            (expand-file-name "bin"            "~"))
      (setq custom-file                     (expand-file-name "custom.el"    user-emacs-directory))

      ;; It may not exist yet
      (ignore-errors (load custom-file))
      (load custom-file)

      ;; When finding file in non-existing directory, offer to create the
      ;; parent directory.
      (defun with-buffer-name-prompt-and-make-subdirs ()
        (let ((parent-directory (file-name-directory buffer-file-name)))
          (when (and (not (file-exists-p parent-directory))
                     (y-or-n-p (format "Directory `%s' does not exist! Create it? " parent-directory)))
            (make-directory parent-directory t))))

      (add-to-list 'find-file-not-found-functions #'with-buffer-name-prompt-and-make-subdirs)

      ;; Don't want to complete .hi files.
      (add-to-list 'completion-ignored-extensions ".hi")

      (defun rah-disable-trailing-whitespace-mode ()
        (setq show-trailing-whitespace nil))

      ;; Shouldn't highlight trailing spaces in terminal mode.
      (add-hook 'term-mode #'rah-disable-trailing-whitespace-mode)
      (add-hook 'term-mode-hook #'rah-disable-trailing-whitespace-mode)

      ;; Ignore trailing white space in compilation mode.
      (add-hook 'compilation-mode-hook #'rah-disable-trailing-whitespace-mode)

      (defun rah-prog-mode-setup ()
        ;; Use a bit wider fill column width in programming modes
        ;; since we often work with indentation to start with.
        (setq fill-column 80))

      (add-hook 'prog-mode-hook #'rah-prog-mode-setup)

      ; (defun rah-lsp ()
      ;   (interactive)
      ;   (envrc-mode)
      ;   (lsp))

      ;(defun rah-sort-lines-ignore-case ()
      ;  (interactive)
      ;  (let ((sort-fold-case t))
      ;    (call-interactively 'sort-lines)))


      (defun meow-setup ()
        (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
        (meow-motion-overwrite-define-key
         '("j" . meow-next)
         '("k" . meow-prev))
        (meow-leader-define-key
         ;; SPC j/k will run the original command in MOTION state.
         '("j" . meow-motion-origin-command)
         '("k" . meow-motion-origin-command)
         ;; Use SPC (0-9) for digit arguments.
         '("1" . meow-digit-argument)
         '("2" . meow-digit-argument)
         '("3" . meow-digit-argument)
         '("4" . meow-digit-argument)
         '("5" . meow-digit-argument)
         '("6" . meow-digit-argument)
         '("7" . meow-digit-argument)
         '("8" . meow-digit-argument)
         '("9" . meow-digit-argument)
         '("0" . meow-digit-argument)
         '("/" . meow-keypad-describe-key)
         '("?" . meow-cheatsheet))
        (meow-normal-define-key
         '("0" . meow-expand-0)
         '("9" . meow-expand-9)
         '("8" . meow-expand-8)
         '("7" . meow-expand-7)
         '("6" . meow-expand-6)
         '("5" . meow-expand-5)
         '("4" . meow-expand-4)
         '("3" . meow-expand-3)
         '("2" . meow-expand-2)
         '("1" . meow-expand-1)
         '("-" . negative-argument)
         '(";" . meow-reverse)
         '("," . meow-inner-of-thing)
         '("." . meow-bounds-of-thing)
         '("[" . meow-beginning-of-thing)
         '("]" . meow-end-of-thing)
         '("a" . meow-append)
         '("A" . meow-open-below)
         '("b" . meow-back-word)
         '("B" . meow-back-symbol)
         '("c" . meow-change)
         '("C" . meow-change-save)
         '("d" . meow-kill)
         '("D" . meow-backward-delete)
         '("e" . meow-next-word)
         '("E" . meow-next-symbol)
         '("f" . meow-find)
         '("F" . meow-find-expand)
         '("g" . meow-cancel)
         '("G" . meow-grab)
         '("h" . meow-left)
         '("H" . meow-left-expand)
         '("i" . meow-insert)
         '("I" . meow-open-above)
         '("j" . meow-next)
         '("J" . meow-next-expand)
         '("k" . meow-prev)
         '("K" . meow-prev-expand)
         '("l" . meow-right)
         '("L" . meow-right-expand)
         '("m" . meow-join)
         '("n" . meow-search)
         '("N" . meow-pop-search)
         '("o" . meow-open-below)
         '("O" . meow-open-above)
         '("p" . meow-clipboard-yank)
         '("P" . meow-clipboard-yank)
         '("q" . meow-quit)
         '("Q" . meow-goto-line)
         '("r" . meow-replace)
         '("R" . meow-swap-grab)
         '("s" . meow-save)
         '("t" . meow-till)
         '("T" . meow-till-expand)
         '("u" . meow-undo)
         '("U" . undo-tree-redo)
         '("v" . meow-visit)
         '("V" . meow-kmacro-matches)
         '("w" . meow-next-word)
         '("W" . meow-next-symbol)
         '("x" . meow-line)
         '("X" . meow-kmacro-lines)
         '("y" . meow-save)
         '("Y" . meow-sync-grab)
         '("z" . meow-pop-selection)
         '("Z" . meow-pop-all-selection)
         '("&" . meow-query-replace)
         '("%" . meow-query-replace-regexp)
         '("'" . repeat)
         '("\\" . quoted-insert)
         '("<escape>" . meow-last-buffer)))

      ; ;; Connect M-x to ivy-rich
      ; (use-package counsel
      ;   :bind (("M-x" . counsel-M-x)
      ;          ("C-x b" . counsel-ibuffer)
      ;          ("C-x C-f" . counsel-find-file)
      ;          :map minibuffer-local-map
      ;          ("C-r" . 'counsel-minibuffer-history))
      ;   :config
      ;   (setq ivy-initial-inputs-alist nil)) ;; Don't start search with ^


      ;; counsel-projectile
      (provide 'workspace)

      ;; splash
      (provide 'splash)

      ;; magit
      (provide 'vsc)

      (add-to-list 'load-path "${tree-sitter}/core")
      (add-to-list 'load-path "${tree-sitter}/lisp")
      (add-to-list 'load-path "${tree-sitter}/langs")

      (setq tsc-dyn-dir (expand-file-name "tree-sitter/" user-emacs-directory))
    '';

    usePackage = {
      all-the-icons = {
        enable = true;
      };

      counsel-projectile = {
        enable = true;
        bind = {
          "C-SPC" = "counsel-projectile-switch-project";
        };
        config = ''
          (counsel-projectile-mode)
        '';
      };

      doom-themes = {
        enable = true;
        config = ''
          (load-theme 'doom-one t)
        '';
      };

      dashboard = {
        enable = true;
        config = ''
          (setq show-week-agenda-p t)
          (setq dashboard-items '((recents . 15) (agenda . 5)))
          (setq dashboard-set-heading-icons t)
          (setq dashboard-set-file-icons t)
          (setq dashboard-startup-banner 3)
          (dashboard-setup-startup-hook)
        '';
      };

      swiper = {
        enable = true;
      };

      ivy = {
       enable = true;
       diminish = [ "ivy-mode" ];
       command = [ "ivy-mode" ];
       config = ''
         (setq ivy-use-virtual-buffers t
               ivy-wrap t
               ivy-count-format "%d/%d "
               enable-recursive-minibuffers t
               ivy-virtual-abbreviate 'full)

         (define-key ivy-minibuffer-map (kbd "TAB") #'ivy-alt-done)
         (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
         (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-next-line)
         (define-key ivy-minibuffer-map (kbd "C-k") #'ivy-previous-line)

         (define-key ivy-switch-buffer-map (kbd "C-l") #'ivy-done)
         (define-key ivy-switch-buffer-map (kbd "C-j") #'ivy-next-line)
         (define-key ivy-switch-buffer-map (kbd "C-k") #'ivy-previous-line)
         (define-key ivy-switch-buffer-map (kbd "C-d") #'ivy-switch-buffer-kill)

         (define-key ivy-reverse-i-search (kbd "C-l") #'ivy-done)
         (define-key ivy-reverse-i-search (kbd "C-j") #'ivy-next-line)
         (define-key ivy-reverse-i-search (kbd "C-k") #'ivy-previous-line)
         (define-key ivy-reverse-i-search (kbd "C-d") #'ivy-reverse-i-search-kill)

         (ivy-mode 1)
       '';
      };

      magit = {
        enable = true;
        config = ''
          (setq magit-completing-read-function 'ivy-completing-read)
        '';
        bind = {
          "C-x g s" = "magit-status";
          "C-x g x" = "magit-checkout";
          "C-x g c" = "magit-commit";
          "C-x g p" = "magit-push";
          "C-x g u" = "magit-pull";
          "C-x g e" = "magit-ediff-resolve";
          "C-x g r" = "magit-rebase-interactive";
        };
      };

      meow = {
        enable = true;
        demand = true;
        init = ''
          (meow-global-mode 1)
        '';
        config = ''
          (meow-setup)
          ;; If you want relative line number in NORMAL state(for display-line-numbers-mode)
          (meow-setup-line-number)
          ;; If you need setup indicator, see `meow-indicator' for customizing by hand.
          (meow-setup-indicator)
        '';
      };

      nix-mode = {
        enable = true;
      };

      page-break-lines = {
        enable = true;
      };

      projectile = {
        enable = true;
        diminish = ["projectile-mode"];
        config = ''
          (setq projectile-completion-system 'ivy)
          (projectile-global-mode)
        '';
        bindKeyMap = {
          "C-c p" = "projectile-command-map";
        };
        init = ''
          (setq projectile-project-search-path '("~/src"))
          (setq projectile-switch-project-action #'projectile-dired)
        '';
      };

      rust-mode = {
        enable = true;
      };

      tree-sitter = {
        enable = true;
      };

      tree-sitter-langs = {
        enable = true;
      };

      undo-tree = {
        config = ''
          (global-undo-tree-mode 1)
        '';
      };

      which-key = {
        enable = true;
        diminish = ["which-key-mode"];
        config = ''
          (which-key-mode)
          (setq which-key-idle-delay 1)
        '';
      };
    };
  };

  programs.emacs.extraPackages = epkgs: with epkgs; [
    counsel
  ];
}
