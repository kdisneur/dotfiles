(setq minitest-packages '((minitest :location
                                    (recipe :fetcher github
                                            :repo "kdisneur/minitest-emacs"))))

(defun minitest/init-minitest ()
  (use-package minitest))
