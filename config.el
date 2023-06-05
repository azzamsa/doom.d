;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "azzamsa"
      user-mail-address "vcs@azzamsa.com")
;;
;; Better defaults
;;

;; Revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)
;; Sort by modified time
(setq dired-listing-switches "-alhFt")
;; Ranger doesn't pickup `dired-listing-switches'
(setq ranger-listing-switches "-althFt")
;; Both doesn't work in Ranger. I need to set the sorting
;; manually and make it persists.
(setq ranger-persistent-sort t)
;; Delete files to trash , as an extra layer of precaution against
;; accidentally deleting wanted files.
;; Doom only enabled it on macOS
(setq delete-by-moving-to-trash t)

;;
;; Buit-in
;;

;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
(after! company
  (setq company-idle-delay 0.5))

(use-package! abbrev
  :defer 1
  :init
  (setq-default abbrev-mode t)
  :config
  (setq abbrev-file-name (concat doom-user-dir "abbrevs.el"))
  (setq save-abbrevs 'silently))

;;
;; UI
;;

(setq doom-theme 'doom-dracula)
;; (setq doom-theme 'doom-tomorrow-day)

;; "monospace" means use the system default. However, the default is usually two
;; points larger than I'd like, so I specify size 12 here.
(setq doom-theme 'doom-dracula
      doom-font (font-spec :family "Iosevka Nerd Font" :size 21 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 21))
;; Noto Sans sometimes doesn't work
(add-to-list 'doom-emoji-fallback-font-families "Twemoji")

;; Use the default font for neotree
(setq doom-neotree-enable-variable-pitch nil)

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

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
;; Modules
;;

;; Emacs doesn't play well with fish
(setq shell-file-name "/bin/bash")

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;;; :tools lsp
;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-ui-sideline-enable nil   ; not anymore useful than flycheck
        lsp-ui-doc-enable nil        ; slow and redundant with K
        lsp-enable-symbol-highlighting nil
        ;; If an LSP server isn't present when I start a prog-mode buffer, you
        ;; don't need to tell me. I know. On some systems I don't care to have a
        ;; whole development environment for some ecosystems.
        +lsp-prompt-to-install-server nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))     ; redundant with K

;; My helper functions
(use-package! aza-scripts
  :defer 3)

(setq projectile-project-search-path '("~/projects" "~/office" "~/playground"))

;; It is 21st century, should I save file manually?
(use-package! super-save
  :defer 3
  :config
  (add-to-list 'super-save-triggers 'vertico)
  (add-to-list 'super-save-triggers 'magit)
  (add-to-list 'super-save-triggers 'find-file)
  (add-to-list 'super-save-triggers 'winner-undo)
  ;; Need to explicitly load the mode
  (super-save-mode +1))

(use-package! treemacs
  :defer t
  :config
  (add-to-list 'treemacs-litter-directories '("target"))
  (setq treemacs-workspace-switch-cleanup t))

;;; :tools magit
(after! magit
  :config
  (setq magit-diff-refine-hunk 'all)
  (setq magit-log-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18)))

(after! vterm
  :config
  (setq vterm-shell "/bin/zsh"))

;; `hl-line-mode' breaks rainbow-mode when activated together
(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

(use-package! web-mode
  :defer 3
  :mode "\\.njk\\'")

(use-package! lsp-tailwindcss
  :after web-mode
  :config
  ;; lsp-mode doen't khow what is njk producing `Unable to calculate the languageId for buffer …'
  (add-to-list 'lsp-language-id-configuration '(".*\\.njk$" . "html")))
