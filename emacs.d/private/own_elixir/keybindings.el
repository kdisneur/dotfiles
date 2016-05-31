(defun own-elixir-binding-keys ()
  (local-set-key (kbd "C-c eip") 'own-elixir-inspect-next-pipe)
  (local-set-key (kbd "C-c eiP") 'own-elixir-inspect-previous-pipe))

(add-hook 'elixir-mode-hook 'own-elixir-binding-keys)

(spacemacs/declare-prefix-for-mode 'elixir-mode "mi" "inspect")
(spacemacs/set-leader-keys-for-major-mode 'elixir-mode "ip" 'own-elixir-inspect-next-pipe)
(spacemacs/set-leader-keys-for-major-mode 'elixir-mode "iP" 'own-elixir-inspect-previous-pipe)
(spacemacs/set-leader-keys-for-major-mode 'elixir-mode "ir" 'own-elixir-inspect-region)

(spacemacs/set-leader-keys-for-major-mode 'elixir-mode "td" 'own-elixir-mix-dogma)

(spacemacs/declare-prefix-for-mode 'elixir-mode "mw" "wrap")
(spacemacs/set-leader-keys-for-major-mode 'elixir-mode "wh" 'own-elixir-wrap-region-with-hash)
(spacemacs/set-leader-keys-for-major-mode 'elixir-mode "wl" 'own-elixir-wrap-region-with-list)
(spacemacs/set-leader-keys-for-major-mode 'elixir-mode "wp" 'own-elixir-wrap-region-with-parenthesis)
(spacemacs/set-leader-keys-for-major-mode 'elixir-mode "wt" 'own-elixir-wrap-region-with-tuple)
