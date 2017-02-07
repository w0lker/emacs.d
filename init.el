;;; package -- 启动脚本
;;; Commentary:
;;; Code:

(defconst user-lisp-dir (concat user-emacs-directory (file-name-as-directory "lisp")) "存放lisp配置代码目录.")
(defconst user-temp-dir (concat user-emacs-directory (file-name-as-directory "temp")) "运行时生产的数据的保存目录.")

(require 'package)
(setq package-enable-at-startup nil
      package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
      package-user-dir (concat user-temp-dir "elpa")
      )
(package-initialize)

(add-to-list 'load-path user-lisp-dir)

(require 'init-core)

(require 'init-theme)
(require 'init-editor)
(require 'init-frame)
(require 'init-window)

(require 'init-evil)
(require 'init-dired)
(require 'init-ido)
(require 'init-ibuffer)
(require 'init-recentf)
(require 'init-tramp)

(require 'init-projectile)
(require 'init-magit)
(require 'init-flycheck)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-search)

(require 'init-org)
(require 'init-tex)
(require 'init-python)
(require 'init-cpp)
(require 'init-golang)
(require 'init-web)
(require 'init-markdown)
(require 'init-sql)
(require 'init-shell)

(require 'init-last)

(provide 'init)
;;;  init.el ends here
