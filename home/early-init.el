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
                            :height 100
                            :family "Fira Code")
        (set-face-attribute 'variable-pitch
                            nil
                            :family "DejaVu Sans")

        ;; Please don't load outdated byte code
        (setq load-prefer-newer t)

        ;; Debugging
        (setq message-log-max 10000)
