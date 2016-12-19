;;; package --- Shell 配置
;;; Commentary:
;;; Code:

(defun my/shell/config-comint-prompt ()
  "设置 buffer local 级别的提示符配置."
  (make-local-variable 'comint-prompt-read-only)
  (setq comint-prompt-read-only t))
(add-hook 'shell-mode-hook 'my/shell/config-comint-prompt)

;; 配置 company 补全
(require-package 'company-shell)
(add-hook 'shell-mode-hook (lambda () (require 'company-shell) (my/completion/push-local-company-backend 'company-shell)))

(require-package 'xterm-color)
(defun my/shell/config-xterm-color ()
  "设置 xterm 颜色."
  (require 'xterm-color)
  (setenv "TERM" "xterm-256color")
  (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
  (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions)))
(add-hook 'shell-mode-hook 'my/shell/config-xterm-color)

(require-package 'bash-completion)
(add-hook 'shell-mode-hook '(lambda () (require 'bash-completion) (bash-completion-setup)))

(defun shell-clear-screen ()
  "清屏操作."
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
(defun my/shell/config-clear-screen-keys ()
  "清屏操作按键键映射为 `C-c l."
  (local-unset-key (kbd "C-c l"))
  (local-set-key (kbd "C-c l") 'shell-clear-screen))
(add-hook 'shell-mode-hook 'my/shell/config-clear-screen-keys)

(provide 'init-shell)
;;; init-shell.el ends here
