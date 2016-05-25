(defconst kdisneur-custom/lisp-function-regex
  "^[[:space:]]*\(defun[ \n\t]+")

(defconst kdisneur-custom/ruby-function-regex
  "^[[:space:]]*\\(def\\|module\\|class\\)[ \n\t]+")

(prodigy-define-tag
  :name 'rails
  :on-output (lambda (&rest args)
               (let ((output (plist-get args :output))
                     (service (plist-get args :service)))
                 (when (or (s-matches? "Listening on 0\.0\.0\.0:[0-9]+, CTRL\\+C to stop" output)
                           (s-matches? "Ctrl-C to shutdown server" output))
                   (prodigy-set-status service 'ready)))))

(defun kdisneur-custom/create-next-line-and-goto ()
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))

(defun kdisneur-custom/create-previous-line-and-goto ()
  (interactive)
  (previous-line)
  (kdisneur-custom/create-next-line-and-goto))

(defun kdisneur-custom/find-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun kdisneur-custom/helm-projectile-ag-ruby ()
  (interactive)
  (helm-projectile-ag "--ruby"))

(defun kdisneur-custom/jump-to-lisp-function ()
  (interactive)
  (find-function (function-called-at-point)))

(defun kdisneur-custom/jump-to-next-lisp-function ()
  (interactive)
  (kdisneur-custom/jump-to-next-matching-line kdisneur-custom/lisp-function-regex 'back-to-indentation))

(defun kdisneur-custom/jump-to-previous-lisp-function ()
  (interactive)
  (kdisneur-custom/jump-to-previous-matching-line kdisneur-custom/lisp-function-regex 'back-to-indentation))

(defun kdisneur-custom/jump-to-next-ruby-function ()
  (interactive)
  (kdisneur-custom/jump-to-next-matching-line kdisneur-custom/ruby-function-regex 'back-to-indentation))

(defun kdisneur-custom/jump-to-previous-ruby-function ()
  (interactive)
  (kdisneur-custom/jump-to-previous-matching-line kdisneur-custom/ruby-function-regex 'back-to-indentation))

(defun kdisneur-custom/occur-in-buffer-p (buffer regex)
  "Borrow from Alchemist. Return non-nil if BUFFER contains at least one occurrence of REGEX."
  (with-current-buffer buffer
    (save-excursion
      (save-match-data
        (goto-char (point-min))
        (re-search-forward regex nil t)))))

(defun kdisneur-custom/jump-to-regex (regex before-fn after-fn search-fn reset-fn)
  "Borrow from Alchemist.Jump to REGEX using SEARCH-FN to search for it.
A common use case would be to use `re-search-forward' as the SEARCH-FN.
Call RESET-FN if the regex isn't found at the first try. BEFORE-FN is called
before performing the search while AFTER-FN after."
  (when (kdisneur-custom/occur-in-buffer-p (current-buffer) regex)
    (save-match-data
      (funcall before-fn)
      (unless (funcall search-fn regex nil t)
        (funcall reset-fn)
        (funcall search-fn regex nil t))
      (funcall after-fn))))

(defun kdisneur-custom/jump-to-next-matching-line (regex after-fn)
  "Borrow from Alchemist. Jump to the next line matching REGEX.
Call AFTER-FN after performing the search."
  (kdisneur-custom/jump-to-regex regex 'end-of-line after-fn 're-search-forward 'beginning-of-buffer))

(defun kdisneur-custom/jump-to-previous-matching-line (regex after-fn)
  "Borrow from Alchemist. Jump to the previous line matching REGEX.

Call AFTER-FN after performing the search."
  (kdisneur-custom/jump-to-regex regex 'beginning-of-line after-fn 're-search-backward 'end-of-buffer))

;; move point to previous error
;; based on code by hatschipuh at
;; http://emacs.stackexchange.com/a/14912/2017
(defun flyspell-goto-previous-error (arg)
  "Go to arg previous spelling error."
  (interactive "p")
  (while (not (= 0 arg))
    (let ((pos (point))
          (min (point-min)))
      (if (and (eq (current-buffer) flyspell-old-buffer-error)
               (eq pos flyspell-old-pos-error))
          (progn
            (if (= flyspell-old-pos-error min)
                ;; goto beginning of buffer
                (progn
                  (message "Restarting from end of buffer")
                  (goto-char (point-max)))
              (backward-word 1))
            (setq pos (point))))
      ;; seek the next error
      (while (and (> pos min)
                  (let ((ovs (overlays-at pos))
                        (r '()))
                    (while (and (not r) (consp ovs))
                      (if (flyspell-overlay-p (car ovs))
                          (setq r t)
                        (setq ovs (cdr ovs))))
                    (not r)))
        (backward-word 1)
        (setq pos (point)))
      ;; save the current location for next invocation
      (setq arg (1- arg))
      (setq flyspell-old-pos-error pos)
      (setq flyspell-old-buffer-error (current-buffer))
      (goto-char pos)
      (if (= pos min)
          (progn
            (message "No more miss-spelled word!")
            (setq arg 0))
        (forward-word)))))

(provide 'kdisneur-custom)
