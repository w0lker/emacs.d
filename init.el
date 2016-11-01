;;; package -- 启动脚本
;;; Commentary:
;;; Code:

;; 包管理器
(require 'package)
(setq package-archives '(
   ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
   ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(setq package-enable-at-startup nil)
(package-initialize)

;; 组建文件夹
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; 基本配置
(require 'init-base)
(require 'init-theme)
(require 'init-font)
(require 'init-frame)
(require 'init-window)
(require 'init-xterm)
(require 'init-osx)

;; 扩展功能
(require 'init-evil)
(require 'init-recentf)
(require 'init-ibuffer)
(require 'init-ido)
(require 'init-dired)
(require 'init-grep)
(require 'init-isearch)
(require 'init-tramp)

;; 开发组建
(require 'init-editor)
(require 'init-version-control)
(require 'init-completion)
(require 'init-code-check)

;; 主模式
(require 'init-shell)
(require 'init-email)
(require 'init-markdown)
(require 'init-sql)
(require 'init-python)
(require 'init-cpp)
(require 'init-web)
(require 'init-vagrant)

;; 必须放在最后
(require 'init-locale)

(put 'erase-buffer 'disabled nil)
(put 'set-goal-column 'disabled nil)

(provide 'init)
;;;  init.el ends here
