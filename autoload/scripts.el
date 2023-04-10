;;; ~/.config/doom/autoload/scripts.el -*- lexical-binding: t; -*-

;;;###autoload
(defun file-manager-here ()
  "Open current directory with default file manager"
  (interactive)
  (message "Opening file manager in current directory...")
  ;; `xdg-open' will pick default file manager
  (start-process "" nil "flatpak-spawn" "--host" "xdg-open" "."))

;;;###autoload
(defun terminal-here ()
  "Open a new terminal with current directory as PWD"
  (interactive)
  (message "Opening terminal in %s" default-directory)
  ;; Need to use `expand-file-name` to expand `~` into a full path
  ;; Otherwise, termhere fallback to `$HOME`
  ;; The Rust version of `termhere' only works with `call-process-shell-command',
  ;; `async-shell-command', and `shell-command'. But the (b)ash version works
  ;; out of the box. Including with `start-process'
  (call-process-shell-command (concat "termhere " (expand-file-name default-directory))))
