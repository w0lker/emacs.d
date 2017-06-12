;;; package -- 启动脚本
;;; Commentary:
;;; Code:

(defconst user-lisp-dir (concat user-emacs-directory (file-name-as-directory "lisp")) "存放lisp代码目录.")
(defconst user-conf-dir (concat user-emacs-directory (file-name-as-directory "conf")) "存放非代码配置文件目录.")
(defconst user-temp-dir (concat user-emacs-directory (file-name-as-directory "temp")) "运行时生产数据目录.")

(setq auto-save-list-file-prefix (concat user-temp-dir (file-name-as-directory "auto-save-list") "saves-")
      custom-file (concat user-temp-dir "custom.el") ;; 个性化配置文件目录
      )

(require 'package)
(setq package-enable-at-startup nil
      package-user-dir (concat user-temp-dir "elpa")
      package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

(add-to-list 'load-path user-lisp-dir)

(eval-when-compile (require 'init-macro))

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
(require 'init-scala)
(require 'init-lua)
(require 'init-web)
(require 'init-markdown)
(require 'init-sql)
(require 'init-shell)
(require 'init-docker)

(require 'init-last)

(provide 'init)
;;;  init.el ends here
