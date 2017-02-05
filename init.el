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

(require 'init-before)

(require 'init-core)
(require 'init-project)
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

(require 'init-after)

(provide 'init)
;;;  init.el ends here
