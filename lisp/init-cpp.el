;;; package -- C++ 配置
;;; Commentary:
;;; Code:

;; 关联文件
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; 自动补全
(require 'company)
;; 头文件补全
(require-package 'company-c-headers)
(require 'company-c-headers)
(defun my/cpp/add-c-headers-to-company()
  "添加头文件补全到 company."
  (my/completion/push-local-company-backend 'company-c-headers))
(add-hook 'c-mode-common-hook 'my/cpp/add-c-headers-to-company)

;; 配置 rtags
(require-package 'rtags)
(setq rtags-autostart-diagnostics t)
;; 如果没启动则启动
(add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)

;; 符号补全
(defun my/cpp/add-rtags-to-company()
  "添加 rtags 补全到 company."
  (require 'company-rtags)
  (setq rtags-completions-enabled t)
  (my/completion/push-local-company-backend 'company-rtags))
(add-hook 'c-mode-common-hook 'my/cpp/add-rtags-to-company)

;; 代码检查
(require 'flycheck)
(require 'flycheck-rtags)
(defun my/cpp/add-rtags-to-flycheck()
  "添加 rtags 到 flycheck 中."
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))
(add-hook 'c-mode-common-hook 'my/cpp/add-rtags-to-flycheck)

;; 配置 cmake
(require-package 'cmake-mode)

(provide 'init-cpp)
;;;  init-cpp.el ends here
