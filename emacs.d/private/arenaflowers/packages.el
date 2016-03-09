(setq arenaflowers-packages '(prodigy))

(with-eval-after-load 'prodigy
  (prodigy-define-tag
    :name 'rails
    :on-output (lambda (&rest args)
                (let ((output (plist-get args :output))
                      (service (plist-get args :service)))
                  (when (or (s-matches? "Listening on 0\.0\.0\.0:[0-9]+, CTRL\\+C to stop" output)
                            (s-matches? "Ctrl-C to shutdown server" output))
                                        (prodigy-set-status service 'ready)))))
  (prodigy-define-service
    :name "arenaflowers.net:3002"
    :command "bundle"
    :args '("exec" "rails" "server" "-p" "3002")
    :cwd "/Users/work/app/arena_apps/arenaflowers.net"
    :tags '(arenaflowers rails))

  (prodigy-define-service
    :name "arenaflowers.com:3000"
    :command "bundle"
    :args '("exec" "rails" "server" "-p" "3000")
    :cwd "/Users/work/app/arena_apps/arenaflowers.com"
    :tags '(arenaflowers rails))

  (prodigy-define-service
    :name "api.arenaflowers.net:3003"
    :command "bundle"
    :args '("exec" "rails" "server" "-p" "3003")
    :cwd "/Users/work/app/arena_apps/api.arenaflowers.net"
    :tags '(arenaflowers rails))

  (prodigy-define-service
    :name "pi.arenaflowers.net:3004"
    :command "bundle"
    :args '("exec" "rails" "server" "-p" "3004")
    :cwd "/Users/work/app/arena_apps/pi.arenaflowers.net"
    :tags '(arenaflowers rails)))
