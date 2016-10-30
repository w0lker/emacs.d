;;; package -- 启动脚本
;;; Commentary:
;;; Code:

;; 载入elpa已经安装的插件
(package-initialize)

;; 设置配置文件夹
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

;; 隐藏启动画面
(setq inhibit-startup-screen t)
;; scratch默认不显示任何内容
(setq  initial-scratch-message nil)
;; 关闭出错蜂鸣声
(setq visible-bell t)
(setq  ring-bell-function 'ignore)

;; 不显示工具栏
(if (functionp 'tool-bar-mode)
    (tool-bar-mode -1))
;; 不显示菜单
(if (functionp 'menu-bar-mode)
    (menu-bar-mode -1))
;; 不显示滚动条
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;; 设置默认主模式为text-mode，而不是fundamental-mode
(setq major-mode 'text-mode)

;; 优化翻页速度
(setq jit-lock-defer-time 0.05)

;; 初始包
(require 'init-utils)
(require 'init-elpa)
(require 'init-exec-path)

;; 必需的包
(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)

;; 基础功能
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-themes)
(require 'init-xterm)
(require 'init-fonts)
(require 'init-dired)
(require 'init-isearch)
(require 'init-grep)
(require 'init-evil)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-ido)
(require 'init-recentf)
(require 'init-window)
(require 'init-mmm)
(require 'init-tramp)
(require 'init-shell)
(require 'init-vagrant)

;; 开发功能
(require 'init-editor)
(require 'init-company)
(require 'init-flycheck)
(require 'init-yasnippet)
(require 'init-vc)

;; 主模式
(require 'init-mu4e)
(require 'init-markdown)
(require 'init-sql)
(require 'init-python)
(require 'init-cpp)
(require 'init-web)

;; 必须放在最后
(require 'init-locales)

(put 'erase-buffer 'disabled nil)
(put 'set-goal-column 'disabled nil)

(provide 'init)
;;;  init.el ends here
