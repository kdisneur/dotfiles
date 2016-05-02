(setq own-blog-packages '(prodigy shell-pop))

(defvar own-blog/application-path "/Users/work/app/website")
(defvar own-blog/drafts-folder-path (concat own-blog/application-path "/source/_drafts"))
(defvar own-blog/posts-folder-path (concat own-blog/application-path "/source/_posts"))

(with-eval-after-load 'prodigy
  (prodigy-define-tag
    :name 'jekyll
    :on-output (lambda (&rest args)
                (let ((output (plist-get args :output))
                      (service (plist-get args :service)))
                  (when (s-matches? "Server running... press ctrl-c to stop." output)
                                        (prodigy-set-status service 'ready)))))
  (prodigy-define-service
    :name "kevin.disneur.me"
    :url "http://127.0.0.1:4321"
    :command "bundle"
    :args '("exec" "jekyll" "serve" "--watch" "--port" "4321" "--drafts")
    :cwd own-blog/application-path
    :tags '(perso jekyll)))

(defun own-blog/create-draft (post-title)
  (interactive "sPost title: ")
  (let ((post-file (own-blog/draft-file-path post-title)))
    (if (file-exists-p post-file)
        (find-file post-file)
      (find-file post-file)
      (insert (format (own-blog/post-template) post-title)))))

(defun own-blog/deploy ()
  (interactive)
  (shell-pop-term 1)
  (comint-send-string "*term-1*"
                      (concat "cd " own-blog/application-path "\n"
                              "bundle exec jekyll deploy\n")))

(defun own-blog/publish-draft ()
  (interactive)
  (let ((current-file-name (buffer-file-name (current-buffer)))
        (new-file-name
         (own-blog/post-file-path
          (buffer-file-name (current-buffer))))
        (current-position (point)))
    (cond ((not (equal (concat own-blog/drafts-folder-path "/")
                       (file-name-directory current-file-name)))
           (message "This is not a draft post."))
          (t
           (rename-file current-file-name new-file-name)
           (kill-buffer nil)
           (find-file new-file-name)
           (set-window-point (selected-window) current-position)
           (message "Draft published")))))

(defun own-blog/unpublish-post ()
  (interactive)
  (let ((current-file-name (buffer-file-name (current-buffer)))
        (new-file-name
         (own-blog/revert-to-draft-file-path
          (buffer-file-name (current-buffer))))
        (current-position (point)))
    (cond ((not (equal (concat own-blog/posts-folder-path "/")
                       (file-name-directory current-file-name)))
           (message "This is not a published post."))
          (t
           (rename-file current-file-name new-file-name)
           (kill-buffer nil)
           (find-file new-file-name)
           (set-window-point (selected-window) current-position)
           (message "Post moved back to draft")))))

(defun own-blog/draft-file-path (name)
  (concat own-blog/drafts-folder-path
          "/"
          (own-blog/slug name)
          ".md"))

(defun own-blog/post-file-path (file-name)
  (concat own-blog/posts-folder-path
          "/"
          (format-time-string "%Y-%m-%d")
          "-"
          (file-name-nondirectory file-name)))

(defun own-blog/post-template ()
  (concat "---\n"
          "layout: post\n"
          "title: %s\n"
          "description: > \n"
          "  <decription here>\n"
          "tags:\n"
          "  - \n"
          "---"))

(defun own-blog/revert-to-draft-file-path (file-name)
  (concat own-blog/drafts-folder-path
          "/"
          (replace-regexp-in-string
           "^[0-9]+-[0-9]+-[0-9]+-"
           ""
           (file-name-nondirectory file-name))))

(defun own-blog/slug (name)
  (downcase
   (replace-regexp-in-string
    " " "-" (replace-regexp-in-string
             "[^A-Za-z0-9 ]" "" name))))
