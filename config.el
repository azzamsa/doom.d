;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "azzamsa"
      user-mail-address "vcs@azzamsa.com")
;;
;; better defaults
;;

;; Line numbers are pretty slow all around. The performance boost of
;; disabling them outweighs the utility of always keeping them on.
(setq display-line-numbers-type nil)

;; Sort by modified time
(setq dired-listing-switches "-alhFt")
;; Ranger doesn't pickup `dired-listing-switches'
(setq ranger-listing-switches "-althFt")
;; Both doesn't work in Ranger. I need to set the sorting
;; manually and make it persists.
(setq ranger-persistent-sort t)

;;
;; looks
;;

(setq doom-theme 'doom-dracula)
;; (setq doom-theme 'doom-tomorrow-day)

;; "monospace" means use the system default. However, the default is usually two
;; points larger than I'd like, so I specify size 12 here.
(setq doom-font (font-spec :family "Fira Code" :size 20))

;; Use the default font for neotree
(setq doom-neotree-enable-variable-pitch nil)

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;;
;; buit-in
;;

;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
(setq company-idle-delay 0.5)


(use-package! org
  :config
  (defun goto-last-heading ()
    "Useful when adding new heading"
    (interactive)
    (org-end-of-subtree))

  ;; add time information when a task moves to a DONE state
  (setq org-log-done 'time)

  (setq org-todo-keywords '((sequence "TODO(t!)" "|" "DONE(d!)")
                            (sequence "WAITING(w@/!)" "|")
                            (sequence "DOING(s!)" "|")
                            (sequence "|" "CANCELED(c@)"))))

(defun file-manager-here ()
  "Open current directory with default file manager"
  (interactive)
  (message "Opening file manager in current directory...")
  ;; `xdg-open' will pick default file manager
  (start-process "" nil "xdg-open" "."))

(defun terminal-here ()
  "Open a new terminal with current directory as PWD"
  (interactive)
  (message "Opening terminal in %s" default-directory)
  ;; Need to use `expand-file-name` to expand `~` into a full path
  ;; Otherwise, wezeterm-here fallback to `$HOME`
  (start-process "" nil "wezterm-here"  (expand-file-name default-directory)))

;;
;; Keybindings
;;

;; Until the related PR merged, I neeed to configure colemak binding manually
;; https://github.com/hlissner/doom-emacs/issues/783
(use-package! evil-colemak-basics
  :after evil
  :init
  (setq evil-colemak-basics-layout-mod `mod-dh)
  :config
  (global-evil-colemak-basics-mode))

;; ranger.el doensn't bind `g g' by default
(map! :after ranger
      :map ranger-mode-map
      "g g" #'ranger-goto-top)

;;
;; misc
;;

;; Emacs doesn't play well with fish
(setq shell-file-name "/bin/bash")

;; Disable invasive lsp-mode features
(setq lsp-ui-sideline-enable nil   ; not anymore useful than flycheck
      lsp-ui-doc-enable nil        ; slow and redundant with K
      lsp-enable-symbol-highlighting nil
      ;; If an LSP server isn't present when I start a prog-mode buffer, you
      ;; don't need to tell me. I know. On some systems I don't care to have a
      ;; whole development environment for some ecosystems.
      +lsp-prompt-to-install-server 'quiet)

;; Emacs LSP on Rust file is nightmare
;(after! rustic
;  (setq rustic-lsp-client nil))

;; It is 21st century, should I save file manually?
(use-package! super-save
  :config
  (add-to-list 'super-save-triggers 'vertico)
  (add-to-list 'super-save-triggers 'magit)
  (add-to-list 'super-save-triggers 'find-file)
  (add-to-list 'super-save-triggers 'winner-undo)

  ;; Need to explicitly load the mode
  (super-save-mode +1))

;; `hl-line-mode' breaks rainbow-mode when activated together
(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

(use-package! lsp-tailwindcss
  :config
  ;; lsp-mode doen't khow what is njk producing `Unable to calculate the languageId for buffer …'
  (add-to-list 'lsp-language-id-configuration '(".*\\.njk$" . "html")))

(use-package! web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode)))
