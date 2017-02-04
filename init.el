;;; package -- 启动脚本
;;; Commentary:
;;; Code:

(defconst user-lisp-dir (concat user-emacs-directory (file-name-as-directory "lisp")) "存放lisp配置代码目录.")
(defconst user-temp-dir (concat user-emacs-directory (file-name-as-directory "temp")) "运行时生产的数据的保存目录.")

(defconst auto-save-list-file-prefix (concat user-temp-dir (file-name-as-directory "auto-save-list") "saves-") "自动保存文件前缀.")
(defconst custom-file (concat user-temp-dir "custom.el") "个性化配置文件名称文件.")

(require 'package)
(setq package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(setq package-enable-at-startup nil)
(setq-default package-user-dir (concat user-temp-dir "elpa"))
(package-initialize)

(defun fetch-package (package-name)
  "下载指定 PACKAGE-NAME 包."
  (condition-case err
      (if (package-installed-p package-name)
	  t
	(progn
	  (unless (assoc package-name package-archive-contents)
	    (package-refresh-contents))
	  (package-install package-name))
	)
    (error (message "Fetch package `%s': %S" package-name err) nil)))

(add-to-list 'load-path user-lisp-dir)

(require 'init-before)

(require 'init-core)

(require 'init-project)
(require 'init-completion)
(require 'init-code-check)
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
