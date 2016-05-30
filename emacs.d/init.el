;; Dependencies:
;; * aspell (spelling errors)
;; * eslint (JS errors)
;; * rubocop (ruby errors)
;; * dogma (elixir errors)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'before-save-hook 'whitespace-cleanup)

(setq vc-follow-symlinks t)

(set-terminal-coding-system 'utf-8-unix)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
       '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
(setq use-package-always-ensure t)

(use-package alchemist
  :config
  (setq alchemist-key-command-prefix (kbd "C-c ,"))
  (setq alchemist-compile-command "elixirc"))

(use-package multi-term
  :config
  (setq multi-term-program "/bin/zsh"))

(use-package company
  :defer t
  :init
  (global-company-mode))

(use-package expand-region)

(use-package flycheck
  :config
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                            '(json-jsonlist)))
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  :init
  (global-flycheck-mode))

(use-package helm
  :config
  (setq helm-recentf-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-lisp-fuzzy-completion t)
  (setq helm-mode-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t)
  :init
  (use-package helm-ag)
  (use-package helm-flyspell)
  (use-package helm-projectile
    :config
    (helm-projectile-on)))

(use-package highlight-parentheses
  :init
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode))

(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  :init
  (use-package js2-refactor
    :config
    (add-hook 'js2-mode-hook #'js2-refactor-mode)))

(use-package markdown-mode
  :commands
  (markdown-mode gfm-mode)
  :mode
  (("\\.md\\'" . gfm-mode)
   ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown"))

(use-package multiple-cursors)

(use-package open-junk-file)

(use-package smartparens
  :init
  (require 'smartparens-config)
  (add-hook 'prog-mode-hook #'smartparens-mode))

(use-package prodigy)

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-global-mode t))

(use-package relative-line-numbers
  :config
  (global-relative-line-numbers-mode)
  (setq relative-line-numbers-max-count 200))

(use-package restart-emacs)

(use-package shackle
  :init
  (setq shackle-rules '(("\\`\\*helm.*?\\*\\'" :regexp t :align t :ratio 0.4))))

(use-package rubocop
  :init
  (add-hook 'ruby-mode-hook #'rubocop-mode))

(use-package ruby-hash-syntax)

(use-package ruby-refactor
  :init
  (add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch))

(use-package ruby-tools)

(use-package shell-pop)

(use-package spaceline
  :init
  (require 'spaceline-config)
  (spaceline-emacs-theme))

(use-package spacemacs-theme
  :config
  (load-theme 'spacemacs-dark t)
  :init
  (require 'spacemacs-dark-theme))

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  :init
  (progn
    (defun on-web-mode-load-hook ()
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-css-indent-offset 2)
      (setq web-mode-code-indent-offset 2))
    (add-hook 'web-mode-hook  'on-web-mode-load-hook))
  (use-package better-jsx
    :ensure f
    :load-path "private/"))

(use-package which-key
  :config
  (setq which-key-idle-delay 1.0)
  (which-key-declare-prefixes "C-. a" "Application")
  (which-key-declare-prefixes "C-. a t" "Terminal")
  (which-key-declare-prefixes "C-. b" "Buffers")
  (which-key-declare-prefixes "C-. e" "Error")
  (which-key-declare-prefixes "C-. f" "File")
  (which-key-declare-prefixes "C-. j" "Jump")
  (which-key-declare-prefixes "C-. p" "Project")
  (which-key-declare-prefixes "C-. q" "Quit & Restart")
  (which-key-declare-prefixes "C-. r" "Refactoring")
  (which-key-declare-prefixes "C-. s" "Text")
  (which-key-declare-prefixes "C-. t" "Test")
  (which-key-declare-prefixes "C-. x" "Execution")
  :init
  (which-key-mode))

(use-package kdisneur-custom
  ;; Needs to be loaded at the end, it defines binding for all
  ;; packages
  :ensure f
  :load-path "private/"
  :init
  (add-hook 'text-mode-hook 'flyspell-mode)
  (require 'misc)
  (use-package kdisneur-arenaflowers
    :ensure f
    :load-path "private/")
  (use-package kdisneur-keybindings
    :ensure f
    :load-path "private/"))
