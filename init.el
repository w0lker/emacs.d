(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defconst *is-a-mac* (eq system-type 'darwin))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-utils)
(require 'init-elpa)

;;-----------------------------------------------------------------------
;; Load configs for specific features and modes
;;-----------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)

(require 'init-frames)
(require 'init-themes)
(require 'init-dired)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-recentf)
(require 'init-ido)
(require 'init-hippie-expand)
(require 'init-auto-complete)
(require 'init-cedet)
(require 'init-flycheck)
(require 'init-windows)
(require 'init-sessions)
(require 'init-editing-utils)
(require 'init-markdown)
(require 'init-org)
(require 'init-nxml)
(require 'init-html)
(require 'init-python-mode)
(require 'init-elm)
(require 'init-dash)
(require 'init-projectile)
(require 'init-evil)

(when (file-exists-p custom-file)
  (load custom-file))
