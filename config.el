;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "azzamsa"
      user-mail-address "noreply@azzamsa.com")

;; Emacs doesn't play well with fish
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")

(setq doom-font (font-spec :family "Maple Mono NF" :size 25)
      doom-variable-pitch-font (font-spec :family "Maple Mono NF" :size 25))

(use-package modus-themes
  :config
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t)
  (setq modus-themes-common-palette-overrides
        '(
          (bg-active   "#2f3849") ; bg-hl-line
          (bg-dim      "#0d0e1c") ; bg-main

          (bg-region bg-active)
          ;; Modeline
          (bg-mode-line-active bg-active)
          (border-mode-line-active bg-mode-line-active)
          (bg-mode-line-inactive bg-dim)
          (border-mode-line-inactive bg-mode-line-inactive)
          ;; Line numbers
          (bg-line-number-active bg-dim)))
  (load-theme 'modus-vivendi t))

;; It is 21st century, should I save file manually?
(use-package! super-save
  :config
  (setq super-save-auto-save-when-idle t)
  ;; Save silently
  (setq super-save-silent t)
  (super-save-mode +1))

(after! dirvish
  (setq dirvish-hide-details t))

;; Emulate A Terminal, in a region, in a buffer and in Eshell
(use-package eat
  :config
  (keymap-global-set "C-/" 'eat-toggle))

(defun eat-toggle ()
  (interactive)
  (if (string= (buffer-name) "*eat*")
      (delete-window)
    (eat-other-window "fish" nil)))
