(setq arenaflowers-application-path "/Users/work/app")
(setq screwcap-path "/Users/work/.rbenv/versions/2.1.6/bin/screwcap")

(when (equal system-type 'gnu/linux)
  (setq arenaflowers-application-path "/home/kevin/code/arenaflowers")
  (setq screwcap-path "/home/kevin/.rbenv/versions/2.1.6/bin/screwcap"))

(defvar arena-apps-path (concatenate 'string arenaflowers-application-path "/arena_apps"))
(defvar arena-apps-script-root-path (concatenate 'string arenaflowers-application-path "/arena_scripts/deployment"))

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
  :tags '(arenaflowers rails))

(provide 'kdisneur-arenaflowers)
