;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-

(doom! :input
       ;;layout          ; auie,ctsrnm is the superior home row

       :completion
       ;;company         ; the ultimate code completion backend
       (corfu +orderless +dabbrev +icons)  ; complete with cap(f), cape and a flying feather!
       vertico           ; the search engine of the future

       :ui
       doom                ; what makes DOOM look the way it does
       dashboard           ; a nifty splash screen for Emacs
       doom-quit           ; DOOM quit-message prompts when you quit Emacs
       (emoji +unicode)    ; 🙂
       hl-todo             ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       indent-guides       ; highlighted indent columns
       ligatures           ; ligatures and symbols to make your code pretty again
       minimap             ; show a map of the code on the side
       modeline            ; snazzy, Atom-inspired modeline, plus API
       nav-flash           ; blink cursor line after big motions
       neotree             ; a project drawer, like NERDTree for vim
       ophints             ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       ;;smooth-scroll     ; So smooth you won't believe it's not butter
       ;;tabs              ; a tab bar for Emacs
       unicode             ; extended unicode support for various languages
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe     ; fringe tildes to mark beyond EOB
       ;;window-select     ; visually switch windows
       ;;workspaces        ; tab emulation, persistence & separate workspaces
       zen                 ; distraction-free coding or writing

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       ;;file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       (whitespace +guess +trim)  ; a butler for your whitespace
       word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +dirvish)  ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       tramp             ; remote files at your arthritic fingertips
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       ghostel           ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       spell               ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       ;;direnv
       docker
       editorconfig        ; let someone else argue about tabs vs spaces
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       ;;llm               ; when I said you needed friends, I didn't mean...
       (lsp +eglot)        ; M-x vscode
       magit               ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       tree-sitter         ; syntax and parsing, sitting in a tree...

       :os
       (:if (featurep :system 'macos) macos)  ; improve compatibility with macOS

       :lang
       beancount         ; mind the GAAP
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       (go +lsp)         ; the hipster dialect
       (json +tree-sitter)               ; At least it ain't XML
       (javascript +lsp +tree-sitter)    ; all(hope(abandon(ye(who(enter(here))))))
       (lua +lsp +tree-sitter)           ; one-based indices? one-based indices
       (markdown +tree-sitter)           ; writing docs for people to ignore
       (python +lsp +tree-sitter +uv +pyright)      ; beautiful is better than ugly
       (rust +lsp +tree-sitter)          ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       scad                              ; trust the preview, regret the render
       (sh +fish +tree-sitter)           ; she sells {ba,z,fi}sh shells on the C xor
       (web +tree-sitter)                ; the tubes
       (yaml +tree-sitter)               ; JSON, but readable

       :config
       (default +bindings +smartparens))

(add-to-list 'initial-frame-alist '(background-color . "#000000"))
