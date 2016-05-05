(defun own-tmux/open-tmux-split-to-current-project ()
  (interactive)
  (own-tmux/open-tmux-split-with-path (projectile-project-root)))

(defun own-tmux/create-tmux-pane (pane-number)
  (own-tmux/run-tmux-command (concat "split-window -v")))

(defun own-tmux/move-tmux-shell-to-project-root (project-root pane-number)
  (own-tmux/run-tmux-command (concat "send-keys "
                                     "-t " pane-number
                                     " \"cd " project-root "\""
                                     " C-m")))

(defun own-tmux/open-tmux-split-with-path (project-root)
  (let ((pane-number "2"))
    (if (own-tmux/has-tmux-pane-open pane-number)
        (own-tmux/move-tmux-shell-to-project-root project-root pane-number)
      (progn
       (own-tmux/create-tmux-pane pane-number)
       (own-tmux/move-tmux-shell-to-project-root project-root pane-number)))))

(defun own-tmux/has-tmux-pane-open (pane-number)
  (eq 0 (own-tmux/run-tmux-command (concat "select-pane -t " pane-number))))

(defun own-tmux/run-tmux-command (command)
  (call-process-shell-command (concat "tmux " command)))
