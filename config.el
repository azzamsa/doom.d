;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "azzamsa"
      user-mail-address "vcs@azzamsa.com")

;; Line numbers are pretty slow all around. The performance boost of
;; disabling them outweighs the utility of always keeping them on.
(setq display-line-numbers-type nil)

;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
(setq company-idle-delay 0.5)

;; Disable invasive lsp-mode features
(setq lsp-ui-sideline-enable nil   ; not anymore useful than flycheck
      lsp-ui-doc-enable nil        ; slow and redundant with K
      lsp-enable-symbol-highlighting nil
      ;; If an LSP server isn't present when I start a prog-mode buffer, you
      ;; don't need to tell me. I know. On some systems I don't care to have a
      ;; whole development environment for some ecosystems.
      +lsp-prompt-to-install-server 'quiet)

;; Emacs LSP on Rust file is nightmare
(after! rustic
  (setq rustic-lsp-client nil))

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

;;
;;
;;; UI

(setq doom-theme 'doom-dracula)

;; "monospace" means use the system default. However, the default is usually two
;; points larger than I'd like, so I specify size 12 here.
(setq doom-font (font-spec :family "Fira Code" :size 20 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 13)
      ivy-posframe-font (font-spec :family "Fira Code" :size 15))

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;;
;; I don't like working with Emacs internal keyring
(define-key evil-normal-state-map "x" 'delete-forward-char); delete to the black hole
(define-key evil-normal-state-map "X" 'delete-backward-char)

(defun meain/evil-delete-advice (orig-fn beg end &optional type _ &rest args)
    "Make d, c, x to not write to clipboard."
    (apply orig-fn beg end type ?_ args))

(advice-add 'evil-delete :around 'meain/evil-delete-advice)
(advice-add 'evil-change :around 'meain/evil-delete-advice)

;;
;;; Keybindings

;; Until the related PR merged, I neeed to configure colemak binding manually
;; https://github.com/hlissner/doom-emacs/issues/783
(use-package! evil-colemak-basics
  :after evil
  :init
  (setq evil-colemak-basics-layout-mod `mod-dh)
  :config
  (global-evil-colemak-basics-mode))
