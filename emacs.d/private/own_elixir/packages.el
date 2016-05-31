(setq own-elixir-packages '(alchemist))

(defun own-elixir-wrap-region-with (left right)
  (let ((beginning (region-beginning))
        (end (region-end)))
    (save-excursion
      (goto-char beginning)
      (insert left)
      (goto-char (+ end (length left)))
      (insert right))))

(defun own-elixir-inspect-region ()
  (interactive)
  (own-elixir-wrap-region-with "IO.inspect(" ")"))

(defun own-elixir-inspect-next-pipe ()
  (interactive)
  (save-excursion
    (end-of-line)
    (newline-and-indent)
    (insert "|> IO.inspect")))

(defun own-elixir-inspect-previous-pipe ()
  (interactive)
  (save-excursion
    (previous-line)
    (own-elixir-inspect-next-pipe)))

(defun own-elixir-mix-dogma ()
  (interactive)
  (alchemist-mix-execute (list "dogma") 'nil))

(defun own-elixir-wrap-region-with-list ()
  (interactive)
  (own-elixir-wrap-region-with "[" "]"))

(defun own-elixir-wrap-region-with-hash ()
  (interactive)
  (own-elixir-wrap-region-with "%{" "}"))

(defun own-elixir-wrap-region-with-parenthesis ()
  (interactive)
  (own-elixir-wrap-region-with "(" ")"))

(defun own-elixir-wrap-region-with-tuple ()
  (interactive)
  (own-elixir-wrap-region-with "{" "}"))
