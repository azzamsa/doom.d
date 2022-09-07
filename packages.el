;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! evil-colemak-basics)
(package! super-save)
(package! org-cliplink)
(package! fish-mode)
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
(package! lsp-pyright :recipe(:type git :flavor melpa :host github :repo "emacs-lsp/lsp-pyright"))
