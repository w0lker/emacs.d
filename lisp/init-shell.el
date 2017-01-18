;;; package --- Shell 配置
;;; Commentary:
;;; Code:

(defun shell/config-comint-prompt ()
  "设置 buffer local 级别的提示符配置."
  (make-local-variable 'comint-prompt-read-only)
  (setq comint-prompt-read-only t))
(add-hook 'shell-mode-hook 'shell/config-comint-prompt)

(use-package company-shell
  :ensure t
  :config
  (add-hook 'shell-mode-hook (lambda ()
			       (completion/push-local-company-backend 'company-shell)))
  )

(use-package xterm-color
  :ensure t
  :commands xterm-color xterm-color-filter
  :defines xterm-color--test-ansi
  :init
  :config
  (defun shell/config-xterm-color ()
    "设置 xterm 颜色."
    (setenv "TERM" "xterm-256color")
    (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
    (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter))
  (add-hook 'shell-mode-hook 'shell/config-xterm-color)
  )

(use-package bash-completion
  :ensure t
  :commands bash-completion-setup
  :config
  (add-hook 'shell-dynamic-complete-functions 'bash-completion-dynamic-complete)
  )

(defun shell-clear-screen ()
  "清屏操作."
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
(defun shell/config-clear-screen-keys ()
  "清屏操作按键键映射为 `C-c l."
  (local-unset-key (kbd "C-c l"))
  (local-set-key (kbd "C-c l") 'shell-clear-screen))
(add-hook 'shell-mode-hook 'shell/config-clear-screen-keys)

(provide 'init-shell)
;;; init-shell.el ends here
