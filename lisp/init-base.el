;;; package -- 基础工具和配置
;;; Commentary:
;;; Code:

(defun package-install-require (package-name)
  "下载指定 PACKAGE-NAME 包并且导入."
  (unless (package-installed-p package-name)
    (unless (assoc package-name package-archive-contents)
      (package-refresh-contents))
    (package-install package-name))
  (require package-name))

(defun base/config-use-package ()
  "配置 use-package."
  (package-install-require 'use-package)
  (eval-when-compile (require 'use-package))
  (package-install-require 'diminish)
  (package-install-require 'bind-key))
(base/config-use-package)

(use-package cl-lib
  :ensure t
  :config
  (eval-when-compile (require 'cl)))

(use-package fullframe :ensure t)
(use-package scratch :ensure t)
(use-package mwe-log-commands :ensure t)
(use-package wgrep :ensure t)
(use-package project-local-variables :ensure t)

;; 让主模式共存
(use-package mmm-mode
  :ensure t
  :commands mmm-auto
  :init
  (setq mmm-global-mode 'buffers-with-submode-classes)
  (setq mmm-submode-decoration-level 2))

;; 快捷键提示
(use-package guide-key
  :ensure t
  :diminish guide-key-mode
  :init
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  :config
  (guide-key-mode 1))

;; 选中帮助的面板
(setq help-window-select t)

(provide 'init-base)
;;;  init-base.el ends here
