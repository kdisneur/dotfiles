(setq arenaflowers-packages '(prodigy shell-pop))

(defvar application-path "/Users/work/app")
(defvar arena-apps-path (concatenate 'string application-path "/arena_apps"))
(defvar screwcap-path "/Users/work/.rbenv/versions/2.1.6/bin/screwcap")
(defvar script-root-path (concatenate 'string application-path "/arena_scripts/deployment"))

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
    :name "www.arenaflowers.net"
    :url "http://dev.arenaflowers.net:3002"
    :command "bundle"
    :args '("exec" "rails" "server" "-p" "3002")
    :cwd (concatenate 'string arena-apps-path "/arenaflowers.net")
    :tags '(arenaflowers rails))

  (prodigy-define-service
    :name "www.arenaflowers.com"
    :url "http://dev.arenaflowers.com:3000"
    :command "bundle"
    :args '("exec" "rails" "server" "-p" "3000")
    :cwd (concatenate 'string arena-apps-path "/arenaflowers.com")
    :tags '(arenaflowers rails))

  (prodigy-define-service
    :name "api.arenaflowers.net"
    :url "http://dev.api.arenaflowers.net:3003"
    :command "bundle"
    :args '("exec" "rails" "server" "-p" "3003")
    :cwd (concatenate 'string arena-apps-path "/api.arenaflowers.net")
    :tags '(arenaflowers rails))

  (prodigy-define-service
    :name "pi.arenaflowers.net"
    :url "http://dev.pi.arenaflowers.net:3004"
    :command "bundle"
    :args '("exec" "rails" "server" "-p" "3004")
    :cwd (concatenate 'string arena-apps-path "/pi.arenaflowers.net")
    :tags '(arenaflowers rails)))

(defun cap-command-names (type)
  (split-string
   (shell-command-to-string
    (format "%s %s/%s.rb 2> /dev/null | grep -E '^  ' | sed -e 's/ //g'"
            screwcap-path
            script-root-path
            type)) "\n"))

(defun run-cap-command (command)
  (shell-pop-term 1)
  (comint-send-string "*term-1*" (concatenate 'string command "\n")))

(defun generate-cap-command (type cap-command)
  (format "%s %s/%s.rb %s -v\n"
          screwcap-path
          script-root-path
          type
          cap-command))

(defun helm-cap-search (type)
  (mapcar (lambda (cap-command-name)
            (cons cap-command-name (generate-cap-command type cap-command-name)))
          (cap-command-names type)))

(defun helm-source-cap-search (type)
  (helm-build-sync-source (concatenate 'string "Deployment to " type)
    :candidates (helm-cap-search type)
    :action '(("Run deployment" . run-cap-command))
    :fuzzy-match t))

(defun helm-stagcap ()
  "Bring up a stagcap search interface in helm."
  (interactive)
  (helm :sources (helm-source-cap-search "staging")
        :buffer "*helm stagcap*"))

(defun helm-prodcap ()
  "Bring up a prodcap search interface in helm."
  (interactive)
  (helm :sources (helm-source-cap-search "production")
                :buffer "*helm prodcap*"))
