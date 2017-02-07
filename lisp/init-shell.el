;;; package --- Shell 配置
;;; Commentary:
;;; Code:

(with-eval-after-load 'eshell
  (setq eshell-directory-name (concat user-temp-dir "eshell"))
  )

(with-eval-after-load 'shell
  (config-add-hook 'shell-mode-hook
    ;; 设置 buffer local 级别的提示符配置
    (setq-local comint-prompt-read-only t)
    (setq-local comint-input-autoexpand t)
    
    (defun shell/clear-screen ()
      "清屏操作."
      (interactive)
      (let ((comint-buffer-maximum-size 0))
	(comint-truncate-buffer))
      )
    ;; 清屏操作按键键映射为 `C-c l
    (local-unset-key (kbd "C-c l"))
    (local-set-key (kbd "C-c l") 'shell/clear-screen)

    (defun shell/xterm-color-config ()
      "配置 xterm 颜色."
      (config-after-fetch-require 'xterm-color
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
      )
    )

  (config-after-fetch-require 'bash-completion
    (add-hook 'shell-dynamic-complete-functions 'bash-completion-dynamic-complete))
  )

(provide 'init-shell)
;;; init-shell.el ends here
