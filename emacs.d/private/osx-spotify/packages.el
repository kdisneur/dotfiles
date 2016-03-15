(setq osx-spotify-packages '(helm))
;(setq debug-on-error t)

(defvar path-to-config-folder "/Users/work/.config")

;;; In the following file you need to add your Spotify credentials.
;;; following the format:
;;; (defvar osx-spotify-client-id "xxxxxxxx")
;;; (defvar osx-spotify-secret-id "yyyyyyyy")
(defvar path-to-secrets (concatenate 'string path-to-config-folder "/emacs-spotify.el"))
;; The following file will be generated automatically after your first authentication
(defvar path-to-tokens (concatenate 'string path-to-config-folder "/emacs-spotify-tokens.el"))

(defun osx-spotify/ask-to-osx (command)
  (shell-command (format (concatenate 'string
                                      "osascript -e 'tell application \"Spotify\" \n"
                                      "                %s \n"
                                      "              end tell'")
                         command)))

(defun osx-spotify/ask-osx-to-play-track (spotify-id)
  (osx-spotify/ask-to-osx (format "play track \"%s\"" spotify-id)))

(defun osx-spotify/clean-search-term (term)
  (replace-regexp-in-string " " "+" (string-trim term)))

(defun osx-spotify/miliseconds-to-human-time (miliseconds)
  (format-seconds "%h:%.2m:%.2s" (/ miliseconds 1000)))

(defun osx-spotify/execute-post-request (url request-data)
  (let ((url-request-method "POST")
        (url-request-extra-headers `(("Content-Type" . "application/x-www-form-urlencoded")))
        (url-request-data request-data))
    (with-current-buffer
        (url-retrieve-synchronously url)
      (goto-char (+ 1 url-http-end-of-headers))
      (json-read-object))))

(defun osx-spotify/execute-authenticated-get-request (path token)
  (let ((url-request-method "GET")
        (url-http-handle-authentication t)
        (url-request-extra-headers `(("Accept" . "application/json")
                                     ("Content-Type" . "application/json")
                                     ("Authorization" . ,(format "Bearer %s" token)))))
    (with-current-buffer
        (url-retrieve-synchronously (format "https://api.spotify.com/v1%s" path))
      (goto-char (+ 1 url-http-end-of-headers))
      (json-read-object))))

(defun osx-spotify/display-albums-information (albums)
  (mapcar (lambda (album)
            (cons (format "%s • %s\nBy %s • %s • %s songs, %s"
                          (case (intern (cdr (assoc 'album_type album)))
                            (single " S ")
                            (album " A ")
                            (otherwise "N/A"))
                          (cdr (assoc 'name album))
                          (mapconcat 'identity
                                     (mapcar (lambda (artist) (cdr (assoc 'name artist)))
                                             (cdr (assoc 'artists album)))
                                     ", ")
                          (cdr (assoc 'release_date album))
                          (length (cdr (assoc 'items (cdr (assoc 'tracks album)))))
                          (osx-spotify/miliseconds-to-human-time
                           (reduce #'+
                                   (mapcar (lambda (track) (cdr (assoc 'duration_ms track)))
                                           (cdr (assoc 'items (cdr (assoc 'tracks album))))))))
                  album))
          albums))

(defun osx-spotify/display-playlists (playlists)
  (mapcar (lambda (playlist) (cons (cdr (assoc 'name playlist)) playlist)) playlists))

(defun osx-spotify/display-tracks-information (tracks &optional album-name)
  (mapcar (lambda (track)
            (cons (format "%s - %s %s\n%s • %s • %s"
                          (cdr (assoc 'track_number track))
                          (cdr (assoc 'name track))
                          (if (cdr (assoc 'explicit track)) "[explicit]" "")
                          (mapconcat 'identity
                                     (mapcar (lambda (artist) (cdr (assoc 'name artist)))
                                             (cdr (assoc 'artists track)))
                                     ", ")
                          (if album-name
                              album-name
                            (cdr (assoc 'name (cdr (assoc 'album track)))))
                          (osx-spotify/miliseconds-to-human-time
                           (cdr (assoc 'duration_ms track))))
                  track))
          tracks))

(defun osx-spotify/helm-albums ()
  (helm-build-sync-source "Spotify - Albums"
    :candidates (lambda () (osx-spotify/load-albums helm-pattern))
    :volatile t
    :multiline t
    :action '(("Play album" . osx-spotify/action-play-track)
              ("View tracks" . osx-spotify/action-view-tracks))
    :fuzzy-match t))

(defun osx-spotify/helm-album-tracks (album)
  (helm-build-sync-source (format "Spotify - %s tracks"
                                  (cdr (assoc 'name album)))
    :candidates (lambda () (osx-spotify/load-album-tracks album))
    :volatile t
    :multiline t
    :action '(("Play track" . osx-spotify/action-play-track))
    :fuzzy-match t))

(defun osx-spotify/helm-artists ()
  (helm-build-sync-source "Spotify - Artists"
    :candidates (lambda () (osx-spotify/load-artists helm-pattern))
    :volatile t
    :multiline t
    :action '(("View albums" . osx-spotify/action-view-artist-albums))
    :fuzzy-match t))

(defun osx-spotify/helm-artist-albums (artist)
  (helm-build-sync-source (format "Spotify - %s Albums"
                                  (cdr (assoc 'name artist)))
    :candidates (lambda () (osx-spotify/load-artist-albums artist))
    :volatile t
    :multiline t
    :action '(("Play album" . osx-spotify/action-play-track)
              ("View tracks `C-RET'" . osx-spotify/action-view-tracks))
    :fuzzy-match t))

(defun osx-spotify/helm-my-playlists ()
  (helm-build-sync-source "Spotify - My playlists"
    :candidates (osx-spotify/load-my-playlists)
    :action '(("Play" . osx-spotify/action-play-track))
    :fuzzy-match t))

(defun osx-spotify/helm-playlists ()
  (helm-build-sync-source "Spotify - Playlists"
    :candidates (lambda () (osx-spotify/load-playlists helm-pattern))
    :volatile t
    :action '(("Play playlist" . osx-spotify/action-play-track))
    :fuzzy-match t))

(defun osx-spotify/helm-tracks ()
  (helm-build-sync-source "Spotify - Tracks"
    :candidates (lambda () (osx-spotify/load-tracks helm-pattern))
    :volatile t
    :multiline t
    :action '(("Play track" . osx-spotify/action-play-track))
    :fuzzy-match t))

(defun osx-spotify/load-albums (pattern)
  (osx-spotify/refresh-token)
  (load path-to-tokens)
  (let ((result (osx-spotify/request-albums osx-spotify-user-token pattern)))
    (osx-spotify/display-albums-information (cdr (assoc 'albums result)))))

(defun osx-spotify/load-album-tracks (album)
  (osx-spotify/display-tracks-information
   (cdr (assoc 'items (cdr (assoc 'tracks album))))
   (cdr (assoc 'name album))))

(defun osx-spotify/load-artists (pattern)
  (osx-spotify/refresh-token)
  (load path-to-tokens)
  (let ((result (osx-spotify/request-artists osx-spotify-user-token pattern)))
    (let ((artists (cdr (assoc 'items (cdr (assoc 'artists result))))))
      (mapcar (lambda (artist)
                (let ((genre (mapconcat 'identity (cdr (assoc 'genres artist)) ", ")))
                  (cons (format "%s\n%s"
                                (cdr (assoc 'name artist))
                                (if (string= "" genre) "Genres not specified" genre))
                        artist)))
              artists))))

(defun osx-spotify/load-artist-albums (artist)
  (osx-spotify/refresh-token)
  (load path-to-tokens)
  (let ((result (osx-spotify/request-artist-albums osx-spotify-user-token
                                                   (cdr (assoc 'id artist)))))
    (osx-spotify/display-albums-information (cdr (assoc 'albums result)))))

(defun osx-spotify/load-playlists (pattern)
  (osx-spotify/refresh-token)
  (load path-to-tokens)
  (let ((result (osx-spotify/request-playlists osx-spotify-user-token pattern)))
    (let ((playlists (cdr (assoc 'items (cdr (assoc 'playlists result))))))
      (osx-spotify/display-playlists playlists))))

(defun osx-spotify/load-my-playlists ()
  (osx-spotify/refresh-token)
  (load path-to-tokens)
  (let ((result (osx-spotify/request-my-playlists osx-spotify-user-token)))
    (let ((playlists (cdr (assoc 'items result))))
      (osx-spotify/display-playlists playlists))))

(defun osx-spotify/load-tracks (pattern)
  (osx-spotify/refresh-token)
  (load path-to-tokens)
  (let ((result (osx-spotify/request-tracks osx-spotify-user-token pattern)))
    (let ((tracks (cdr (assoc 'items (cdr (assoc 'tracks result))))))
      (osx-spotify/display-tracks-information tracks))))

(defun osx-spotify/request-albums (token pattern)
  (osx-spotify/request-albums-details
   token
   (cdr (assoc 'albums
               (osx-spotify/execute-authenticated-get-request
                (format "/search?q=%s*&type=album"
                        (osx-spotify/clean-search-term pattern))
                token)))))

(defun osx-spotify/request-albums-details (token albums)
  (osx-spotify/execute-authenticated-get-request
   (format "/albums?ids=%s" (mapconcat 'identity
                                       (mapcar (lambda (album) (cdr (assoc 'id album)))
                                               (cdr (assoc 'items albums)))
                                       ","))
   token))

(defun osx-spotify/request-artists (token pattern)
  (osx-spotify/execute-authenticated-get-request
   (format "/search?q=%s*&type=artist"
           (osx-spotify/clean-search-term pattern))
   token))

(defun osx-spotify/request-artist-albums (token artist-id)
  (osx-spotify/request-albums-details
   token
   (osx-spotify/execute-authenticated-get-request (format "/artists/%s/albums" artist-id)
                                                  token)))

(defun osx-spotify/request-exchange-code-to-token (code)
  (load path-to-secrets)
  (osx-spotify/execute-post-request "https://accounts.spotify.com/api/token"
                                    (format (concatenate 'string
                                                         "client_id=%s&"
                                                         "client_secret=%s&"
                                                         "grant_type=authorization_code&"
                                                         "redirect_uri=http%%3A%%2F%%2Flocalhost%%3A3000%%2Fcallback&"
                                                         "code=%s")
                                            osx-spotify-client-id
                                            osx-spotify-secret-id
                                            code)))

(defun osx-spotify/request-my-playlists (token)
  (osx-spotify/execute-authenticated-get-request "/me/playlists" token))

(defun osx-spotify/request-playlists (token pattern)
  (osx-spotify/execute-authenticated-get-request
   (format "/search?q=%s&type=playlist"
           (osx-spotify/clean-search-term pattern))
           token))

(defun osx-spotify/request-refresh-token (refresh-token)
  (load path-to-secrets)
  (osx-spotify/execute-post-request "https://accounts.spotify.com/api/token"
                                    (format (concatenate 'string
                                                         "client_id=%s&"
                                                         "client_secret=%s&"
                                                         "grant_type=refresh_token&"
                                                         "refresh_token=%s&")
                                            osx-spotify-client-id
                                            osx-spotify-secret-id
                                            refresh-token)))

(defun osx-spotify/request-tracks (token pattern)
  (osx-spotify/execute-authenticated-get-request
   (format "/search?q=%s&type=track"
           (osx-spotify/clean-search-term pattern))
           token))

(defun osx-spotify/refresh-token ()
  (load path-to-tokens)
  (let ((result (osx-spotify/request-refresh-token osx-spotify-refresh-token)))
    (let ((user-token (cdr (assoc 'access_token result))))
      (osx-spotify/save-tokens user-token osx-spotify-refresh-token))))

(defun osx-spotify/save-tokens (user-token refresh-token)
  (write-region
   (format (concatenate 'string
                        "(setq osx-spotify-user-token \"%s\")\n"
                        "(setq osx-spotify-refresh-token \"%s\")\n")
           user-token
           refresh-token)
   nil
   path-to-tokens))

(defun osx-spotify/action-play-track (spotify-object)
  (osx-spotify/ask-osx-to-play-track (cdr (assoc 'uri spotify-object))))

(defun osx-spotify/action-view-artist-albums (artist)
  (helm :sources (osx-spotify/helm-artist-albums artist)
        :buffer "*helm view-artist-albums*"))

(defun osx-spotify/action-view-tracks (album)
  (helm :sources (osx-spotify/helm-album-tracks album)
        :buffer "*helm view-tracks*"))

(defun osx-spotify-authenticate ()
  (interactive)
  (load path-to-secrets)
  (browse-url (format (concatenate 'string
                                   "https://accounts.spotify.com/en/authorize?"
                                   "client_id=%s&"
                                   "response_type=code&"
                                   "redirect_uri=http://localhost:3000/callback&"
                                   "scope=playlist-read-private")
                      osx-spotify-client-id))
  (let ((code (read-string "Enter temporary code:")))
    (let ((result (osx-spotify/request-exchange-code-to-token code)))
      (let ((user-token (cdr (assoc 'access_token result)))
            (refresh-token (cdr (assoc 'refresh_token result))))
        (osx-spotify/save-tokens user-token refresh-token)))))

(defun osx-spotify-next ()
  (interactive)
  (osx-spotify/ask-to-osx "next track"))

(defun osx-spotify-play-pause ()
  (interactive)
  (osx-spotify/ask-to-osx "playpause"))

(defun osx-spotify-previous ()
  (interactive)
  (osx-spotify/ask-to-osx "previous track"))

(defun osx-spotify-search-by-my-playlists ()
  (interactive)
  (helm :sources (osx-spotify/helm-my-playlists)
        :buffer "*helm my-playlists*"))

(defun osx-spotify-search-by-albums ()
  (interactive)
  (helm :sources (osx-spotify/helm-albums)
        :buffer "*helm albums*"))

(defun osx-spotify-search-by-artists ()
  (interactive)
  (helm :sources (osx-spotify/helm-artists)
        :buffer "*helm artists*"))

(defun osx-spotify-search-by-tracks ()
  (interactive)
  (helm :sources (osx-spotify/helm-tracks)
        :buffer "*helm tracks*"))

(defun osx-spotify-search-by-playlists ()
  (interactive)
  (helm :sources (osx-spotify/helm-playlists)
        :buffer "*helm playlists*"))
