;; 配置存放位置
(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))

(require 'init-startup)
(require 'init-themes)
(require 'init-ido)
(require 'init-buffer)
(require 'init-dired)
(require 'init-editing)
(require 'init-auto-complete)
(require 'init-cedet)
(require 'init-flymake)
(require 'init-markdown)
(require 'init-dash)
(require 'init-projectile)
(require 'init-evil)

(when (file-exists-p custom-file)
  (load custom-file))
