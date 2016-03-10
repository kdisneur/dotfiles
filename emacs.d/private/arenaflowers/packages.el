(setq arenaflowers-packages '(prodigy shell-pop))

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

(defvar cap-projects
  (list "arenaflowers.com" "partners" "api.arenaflowers.com"))

(defun run-cap-command (command)
  (shell-pop-term 1)
  (comint-send-string "*term-1*" (concatenate 'string command "\n")))

(defun generate-cap-command (type project)
  (concatenate 'string type "cap " project ":deploy"))

(defun helm-cap-search (type)
  (mapcar (lambda (project-name)
            (cons project-name (generate-cap-command type project-name)))
          cap-projects))

(defun helm-source-cap-search (type)
  (helm-build-sync-source (concatenate 'string "Deployment to " type)
    :candidates (helm-cap-search type)
    :action '(("Run deployment" . run-cap-command))
    :fuzzy-match t))

(defun helm-stagcap ()
  "Bring up a stagcap search interface in helm."
  (interactive)
  (helm :sources (helm-source-cap-search "stag")
        :buffer "*helm stagcap*"))

(defun helm-prodcap ()
  "Bring up a prodcap search interface in helm."
  (interactive)
  (helm :sources (helm-source-cap-search "prod")
                :buffer "*helm prodcap*"))
