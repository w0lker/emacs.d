;;; package -- 启动脚本
;;; Commentary:
;;; Code:

(defconst my-lisp-dir "lisp" "存放lisp配置代码目录.")
(defconst my-temp-dir "temp" "运行时生产的数据的保存目录.")

;; 包管理器
(require 'package)
(setq package-archives '(
                         ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
      package-enable-at-startup nil
      package-user-dir (concat user-emacs-directory (file-name-as-directory my-temp-dir) "elpa"))
(package-initialize)

(add-to-list 'load-path (expand-file-name my-lisp-dir user-emacs-directory))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(package-selected-packages
   (quote
    (vagrant-tramp vagrant web-mode emmet-mode cmake-mode rtags google-c-style pip-requirements pyenv-mode-auto pyenv-mode company-anaconda anaconda-mode sql-indent markdown-mode mu4e-alert company-shell flycheck company-quickhelp company dropdown-list yasnippet magit gitconfig-mode gitignore-mode ibuffer-vc projectile browse-kill-ring avy expand-region highlight-escape-sequences fill-column-indicator indent-guide rainbow-delimiters redo+ anzu wgrep-ag ag diff-hl dired-sort dired+ smex ido-ubiquitous swbuff fullframe evil-leader evil switch-window exec-path-from-shell default-text-scale smart-mode-line-powerline-theme smart-mode-line molokai-theme guide-key mmm-mode project-local-variables wgrep mwe-log-commands scratch diminish))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t :background "#403d3d")))
 '(company-scrollbar-fg ((t :background "#f8f7f1")))
 '(company-tooltip ((t :background "#403d3d")))
 '(company-tooltip-annotation ((t :foreground "#92e56d")))
 '(company-tooltip-common ((t :foreground "#f62d6e")))
 '(company-tooltip-common-selection ((t :foreground "#f62d6e")))
 '(company-tooltip-selection ((t :foreground "#f62d6e" :background "#525151")))
 '(swbuff-current-buffer-face ((t :foreground "#ffffff" :background "#6aa84f"))))
