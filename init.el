;;; package -- 启动脚本
;;; Commentary:
;;; Code:


(defconst user-lisp-dir (concat user-emacs-directory (file-name-as-directory "lisp")) "存放lisp配置代码目录.")
(defconst user-deps-dir (concat user-emacs-directory (file-name-as-directory "deps")) "依赖文件目录.")
(defconst user-temp-dir (concat user-emacs-directory (file-name-as-directory "temp")) "运行时生产的数据的保存目录.")
(defconst auto-save-list-file-prefix (concat user-temp-dir (file-name-as-directory "auto-save-list") "saves-"))
(defconst custom-file (concat user-temp-dir "custom.el"))

;; 包管理器
(require 'package)
(setq package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(setq package-enable-at-startup nil)
(setq-default package-user-dir (concat user-temp-dir "elpa"))
(package-initialize)

;; 载入 lisp 配置目录
(add-to-list 'load-path user-lisp-dir)

;; 基本
(require 'init-base)
(require 'init-theme)
(require 'init-frame)
(require 'init-window)
(require 'init-mac)
(require 'init-xterm)

;; 扩展
(require 'init-evil)
(require 'init-buffer)
(require 'init-dired)
(require 'init-recentf)
(require 'init-search)
(require 'init-tramp)

;; 开发
(require 'init-editor)
(require 'init-project)
(require 'init-version-control)
(require 'init-completion)
(require 'init-code-check)

;; 主模式
(require 'init-make)
(require 'init-org)
(require 'init-shell)
(require 'init-markdown)
(require 'init-sql)
(require 'init-python)
(require 'init-cpp)
(require 'init-web)
(require 'init-vagrant)

;; 加载个性化配置
(if (file-exists-p custom-file) (load custom-file))

;; 必须放在最后
(require 'init-locale)

(provide 'init)
;;;  init.el ends here
