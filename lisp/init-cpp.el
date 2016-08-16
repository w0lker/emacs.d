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
(when (maybe-require-package 'rtags)
  (require 'company)
  (require 'company-rtags)
  
  (setq rtags-autostart-diagnostics t)
  (rtags-enable-standard-keybindings)
  
  (setq rtags-completions-enabled t)
  (push 'company-rtags company-backends))


(defun my-flycheck-rtags-setup ()
  "Seting rtags for flycheck."
  (require 'flycheck-rtags)
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

(add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)


(provide 'init-cpp)
;;;  init-cpp.el ends here
