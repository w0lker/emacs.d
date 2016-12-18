;;; package -- C++配置
;;; Commentary:
;;; Code:

;; 关联文件
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; 自动补全
(require 'company)
;; 头文件补全
(require-package 'company-c-headers)
(defun my/cpp/header-add-to-company()
  "添加头文件补全到company."
  (push 'company-c-headers company-backends))
(add-hook 'c-mode-common-hook 'my/cpp/header-add-to-company)

;; rtags配置
(require-package 'rtags)
(setq rtags-autostart-diagnostics t)
;; 如果没启动则启动
(add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)

;; 符号补全
(require 'company-rtags)
(defun my/cpp/rtags-add-to-company()
  "添加rtags补全到company."
  (setq rtags-completions-enabled t)
  (push 'company-rtags company-backends))
(add-hook 'c-mode-common-hook 'my/cpp/rtags-add-to-company)

;; 代码检查
(require 'flycheck)
(require 'flycheck-rtags)
(defun my/cpp/rtags-add-to-flycheck()
  "添加rtags到flycheck中"
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))
(add-hook 'c-mode-common-hook 'my/cpp/rtags-add-to-flycheck)

;; cmake配置
(require-package 'cmake-mode)

(provide 'init-cpp)
;;;  init-cpp.el ends here
