;;; package -- c++-mode配置文件
;;; Commentary:
;;; Code:


;; 指定头文件使用c++－mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;; 代码自动格式化为google风格
(when (maybe-require-package 'google-c-style)
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent))


;; rtags配置
(defun setup-flycheck-rtags ()
  (interactive)
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

(when (maybe-require-package 'rtags)
  (require 'company)
  (require 'company-rtags)

  (setq rtags-autostart-diagnostics t)
  (rtags-enable-standard-keybindings)

  (setq rtags-completions-enabled t)
  (push 'company-rtags company-backends)
  
  ;; 代码检查
  (require 'flycheck-rtags)
  (add-hook 'c-mode-common-hook #'setup-flycheck-rtags))


(provide 'init-cpp)
;;;  init-cpp.el ends here
