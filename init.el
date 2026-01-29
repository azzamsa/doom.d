;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (corfu +orderless)
       vertico

       :ui
       doom
       doom-quit
       hl-todo
       indent-guides
       ligatures
       modeline
       nav-flash
       neotree
       ophints
       (popup +defaults)
       (vc-gutter +pretty)
       vi-tilde-fringe

       :editor
       (evil +everywhere)
       file-templates
       fold
       format
       multiple-cursors
       snippets
       (whitespace +guess +trim)

       :emacs
       (dired +dirvish +icons)
       electric
       tramp
       undo
       vc

       :checkers
       syntax
       (spell +flyspell)

       :tools
       docker
       editorconfig
       (eval +overlay)
       lookup
       ;;llm
       (lsp +eglot)
       (magit +childframe)
       tree-sitter

       :os
       tty

       :lang
       beancount
       emacs-lisp
       (go +lsp)
       json
       ledger
       lua
       markdown
       org
       python
       (rust +lsp)
       (sh +lsp +fish)
       web
       yaml
       ;;zig

       :config
       (default +bindings +smartparens))
