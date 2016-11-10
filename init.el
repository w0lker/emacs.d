;;; package -- 启动脚本
;;; Commentary:
;;; Code:

(defconst my-lisp-dir "lisp" "存放lisp配置代码目录.")
(defconst my-temp-dir "temp" "运行时生产的数据的保存目录.")
(setq custom-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "custom.el"))
;; 存储位置
(setq pyim-directory (concat user-emacs-directory
                             (file-name-as-directory my-temp-dir)
                             "pyim"))
(setq pyim-dcache-directory (concat user-emacs-directory
                                    (file-name-as-directory my-temp-dir)
                                    (file-name-as-directory "pyim")
                                    "dcache"))

;; 包管理器
(require 'package)
(setq package-archives '(
                         ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
      package-enable-at-startup nil
      package-user-dir (concat user-emacs-directory (file-name-as-directory my-temp-dir) "elpa"))
(package-initialize)

;; 载入 lisp 配置目录
(add-to-list 'load-path (expand-file-name my-lisp-dir user-emacs-directory))

;; 基本配置
(require 'init-base)
(require 'init-theme)
(require 'init-font)
(require 'init-frame)
(require 'init-window)
(require 'init-xterm)
(require 'init-osx)
(require 'init-input-method)

;; 扩展功能
(require 'init-evil)
(require 'init-recentf)
(require 'init-buffer)
(require 'init-ido)
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
(require 'init-email)
(require 'init-markdown)
(require 'init-sql)
(require 'init-python)
(require 'init-cpp)
(require 'init-web)
(require 'init-vagrant)

;; 加载个性化配置
(when (file-exists-p custom-file)
  (load custom-file))

;; 必须放在最后
(require 'init-locale)

(provide 'init)
;;;  init.el ends here
