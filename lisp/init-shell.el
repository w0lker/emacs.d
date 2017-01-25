;;; package --- Shell 配置
;;; Commentary:
;;; Code:

(fetch-package 'shell)
(fetch-package 'xterm-color)
(fetch-package 'bash-completion)

(require 'shell)
(defun shell/comint-prompt-config ()
  "设置 buffer local 级别的提示符配置."
  (setq-local comint-prompt-read-only t)
  (setq-local comint-input-autoexpand t))
(add-hook 'shell-mode-hook 'shell/comint-prompt-config)

(defun shell/clear-screen ()
  "清屏操作."
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun shell/clear-screen-keys-config ()
  "清屏操作按键键映射为 `C-c l."
  (local-unset-key (kbd "C-c l"))
  (local-set-key (kbd "C-c l") 'shell/clear-screen))
(add-hook 'shell-mode-hook 'shell/clear-screen-keys-config)

(defun shell/xterm-color-config ()
  "配置 xterm 颜色."
  (require 'xterm-color)
  (progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
	 (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions)))

  (setq compilation-environment '("TERM=xterm-256color"))
  (add-hook 'compilation-start-hook
	    (lambda (proc)
	      (when (eq (process-filter proc) 'compilation-filter)
		(set-process-filter
		 proc
		 (lambda (proc string)
		   (funcall 'compilation-filter proc
			    (xterm-color-filter string)))))))
  )
(add-hook 'shell-mode-hook 'shell/xterm-color-config)

(require 'bash-completion)
(add-hook 'shell-dynamic-complete-functions 'bash-completion-dynamic-complete)

(provide 'init-shell)
;;; init-shell.el ends here
