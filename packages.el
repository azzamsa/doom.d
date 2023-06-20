;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! evil-colemak-basics)
(package! super-save)
(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
(package! just-mode)
(package! ron-mode)
(package! pest-mode)

;; Without `package!', I need to execute `doom/reload' after startup
;; to get aza-script function loaded
(package! aza-scripts
  :recipe (:local-repo "~/projects/aza-scripts/"))

(package! hurl-mode :pin "b5e7256" :recipe
  (:host github
   :repo "Orange-OpenSource/hurl"
   :files ("contrib/emacs/*.el")))
