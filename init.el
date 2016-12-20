;;; package -- 启动脚本
;;; Commentary:
;;; Code:


(defconst my-lisp-dir "lisp" "存放lisp配置代码目录.")
(defconst my-deps-dir "deps" "依赖文件目录.")
(defconst my-temp-dir "temp" "运行时生产的数据的保存目录.")

(setq-default custom-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "custom.el"))

;; 包管理器
(require 'package)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(setq package-enable-at-startup nil)
(setq-default package-user-dir (concat user-emacs-directory (file-name-as-directory my-temp-dir) "elpa"))
(package-initialize)

;; 载入 lisp 配置目录
(add-to-list 'load-path (expand-file-name my-lisp-dir user-emacs-directory))

;; 基本配置
(require 'init-base)
(require 'init-theme)
(require 'init-frame)
(require 'init-window)
(require 'init-xterm)
(require 'init-osx)

;; 扩展功能
(require 'init-evil)
(require 'init-recentf)
(require 'init-buffer)
(require 'init-dired)
(require 'init-grep)
(require 'init-search)
(require 'init-tramp)

;; 开发组建
(require 'init-editor)
(require 'init-project)
(require 'init-version-control)
(require 'init-completion)
(require 'init-code-check)

;; 主模式
(require 'init-org)
(require 'init-shell)
(require 'init-markdown)
(require 'init-sql)
(require 'init-python)
(require 'init-cpp)
(require 'init-web)
(require 'init-docker)

;; 加载个性化配置
(when (file-exists-p custom-file) (load custom-file))

;; 必须放在最后
(require 'init-locale)

(provide 'init)
;;;  init.el ends here
