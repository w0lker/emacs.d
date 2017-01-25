;;; package -- C++ 配置
;;; Commentary:
;;; Code:

(fetch-package 'make-mode)
(fetch-package 'cmake-mode)
(fetch-package 'company-c-headers)

(add-to-list 'auto-mode-alist '("\\(/\\|\\`\\)[Mm]akefile" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . cc-mode))

(require 'make-mode)
(require 'cmake-mode)

(with-eval-after-load 'company
  (require 'company-c-headers)
  (defun cpp/add-c-headers-to-company ()
    "添加头文件补全到 company."
    (completion/push-local-company-backend 'company-c-headers))
  (add-hook 'c-mode-common-hook 'cpp/add-c-headers-to-company))

;; 不要使用 package 安装，因为安装的版本和服务可能会有版本协议不一致的问题
;; brew install rtags --HEAD
;; brew service start rtags
(require 'rtags)
(with-eval-after-load 'rtags
  (setq rtags-autostart-diagnostics t)
  (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)

  (with-eval-after-load 'company
    (require 'company-rtags)
    (defun cpp/add-rtags-to-company ()
      "添加 rtags 补全到 company."
      (setq rtags-completions-enabled t)
      (completion/push-local-company-backend 'company-rtags))
    (add-hook 'c-mode-common-hook 'cpp/add-rtags-to-company))

  (with-eval-after-load 'flycheck
    (require 'flycheck-rtags)
    (defun cpp/add-rtags-to-flycheck ()
      "添加 rtags 到 flycheck 中."
      (flycheck-select-checker 'rtags)
      (setq-local flycheck-highlighting-mode nil)
      (setq-local flycheck-check-syntax-automatically nil))
    (add-hook 'c-mode-common-hook 'cpp/add-rtags-to-flycheck))
  )

(provide 'init-cpp)
;;;  init-cpp.el ends here
