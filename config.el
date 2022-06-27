;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "azzamsa"
      user-mail-address "vcs@azzamsa.com")
;;
;; better defaults
;;

;; Line numbers are pretty slow all around. The performance boost of
;; disabling them outweighs the utility of always keeping them on.
(setq display-line-numbers-type nil)

;;
;; looks
;;

(setq doom-theme 'doom-dracula)

;; "monospace" means use the system default. However, the default is usually two
;; points larger than I'd like, so I specify size 12 here.
(setq doom-font (font-spec :family "Rec Mono Duotone" :size 20))

;; Use the default font for neotree
(setq doom-neotree-enable-variable-pitch nil)

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;;
;; global keybindings
;;
(map! "<M-backspace>" #'my-backward-delete-word)

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

;;
;; workarounds
;;

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (my-delete-word (- arg)))

(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

;; I don't like working with Emacs internal keyring
(define-key evil-normal-state-map "x" 'delete-forward-char); delete to the black hole
(define-key evil-normal-state-map "X" 'delete-backward-char)

(defun meain/evil-delete-advice (orig-fn beg end &optional type _ &rest args)
    "Make d, c, x to not write to clipboard."
    (apply orig-fn beg end type ?_ args))

(advice-add 'evil-delete :around 'meain/evil-delete-advice)
(advice-add 'evil-change :around 'meain/evil-delete-advice)

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

;;
;; misc
;;

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
