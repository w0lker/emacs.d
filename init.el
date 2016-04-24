;; 配置存放位置
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; 配置个性化文件名
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; 统一使用y/n
(defalias 'yes-or-no-p 'y-or-n-p)
(defconst *is-a-mac* (eq system-type 'darwin))

;; GC垃圾收集
(defconst my/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold my/initial-gc-cons-threshold)))

(require 'init-utils)
(require 'init-elpa)
(require 'init-exec-path)

;; 安装需要的包
(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)

(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-themes)
(require 'init-ido)
(require 'init-dired)
(require 'init-isearch)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-ibuffer)

(require 'init-windows)
(require 'init-evil)
(require 'init-editing)
(require 'init-cpp)
(require 'init-markdown)
(require 'init-dash)
(require 'init-projectile)
(require 'init-shell)
