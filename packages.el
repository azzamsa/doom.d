;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! evil-colemak-basics)
(package! super-save)
(package! org-cliplink)
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
(package! lsp-pyright :recipe (:type git :flavor melpa :host github :repo "emacs-lsp/lsp-pyright"))
(package! just-mode)

;; Without `package!', I need to execute `doom/reload' after startup
;; to get aza-script function loaded
(package! aza-scripts
  :recipe (:local-repo "~/projects/aza-scripts/"))
