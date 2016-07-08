(setq arenaflowers-packages '(prodigy shell-pop))

(defvar application-path "/Users/work/app")

(with-eval-after-load 'prodigy
  (prodigy-define-tag
    :name 'phoenix
    :on-output (lambda (&rest args)
                 (let ((output (plist-get args :output))
                       (service (plist-get args :service)))
                   (when (or (s-matches? "Cowboy using http on port [0-9]+" output)
                             (s-matches? "press Ctrl+C to exit" output))
                     (prodigy-set-status service 'ready)))))

  (prodigy-define-tag
    :name 'middleman
    :on-output (lambda (&rest args)
                 (let ((output (plist-get args :output))
                       (service (plist-get args :service)))
                   (when (s-matches? "View your site at " output)
                     (prodigy-set-status service 'ready)))))

  (prodigy-define-service
    :name "api.groomgroom.co"
    :url "http://127.0.0.1:4000"
    :command "mix"
    :args '("phoenix.server")
    :cwd (concatenate 'string application-path "/api.groomgroom.co")
    :tags '(groomgroom phoenix))

  (prodigy-define-service
    :name "developers.groomgroom.co"
    :url "http://127.0.0.1:4567"
    :command "bundle"
    :args '("exec" "middleman" "server")
    :cwd (concatenate 'string application-path "/developers.groomgroom.co")
    :tags '(groomgroom middleman)))
