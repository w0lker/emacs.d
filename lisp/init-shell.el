;;; package --- Shell配置
;;; Commentary:
;;; Code:

(add-hook 'shell-mode-hook (lambda ()
			     (make-local-variable 'comint-prompt-read-only)
			     (setq comint-prompt-read-only t)))

(defun my/shell/clear-shell ()
  "Shell清屏操作."
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
(add-hook 'shell-mode-hook (lambda ()
                             (local-unset-key (kbd "C-c l"))
                             (local-set-key (kbd "C-c l") 'my/shell/clear-shell)))

;; 配置company补全
(when (require-package 'company-shell)
  (add-hook 'shell-mode-hook (lambda ()
                               (my/company/local-push-company-backend 'company-shell))))

(defun my/shell/my-filter (condp lst)
  "Filter match CONDP condition function element from LST."
  (delq nil (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun shell-dwim (&optional create)
  "已经有shell的buffer就直接使用，没有就创建一个.
如果传入产生CREATE，则总是创建新的shell缓冲区."
  (interactive "P")
  (let ((next-shell-buffer) (buffer)
        (shell-buf-list (identity ;;used to be reverse
                         (sort
                          (my/shell/my-filter (lambda (x) (string-match "^\\*shell\\*" (buffer-name x))) (buffer-list))
                          #'(lambda (a b) (string< (buffer-name a) (buffer-name b)))))))
    (setq next-shell-buffer
          (if (string-match "^\\*shell\\*" (buffer-name buffer))
              (get-buffer (cadr (member (buffer-name) (mapcar (function buffer-name) (append shell-buf-list shell-buf-list)))))
            nil))
    (setq buffer
          (if create
              (generate-new-buffer-name "*shell*")
            next-shell-buffer))
    (shell buffer)))

;; 配置xterm的颜色
(add-hook 'shell-mode-hook '(lambda ()
                              (when (require-package 'xterm-color)
                                (require 'xterm-color)
                                (setenv "TERM" "xterm-256color")
                                (progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
                                       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))))))

(defun my/shell/bash-completion ()
  "Bash shell 补全."
  (require-package 'bash-completion)
  (bash-completion-setup)
  )
(add-hook 'shell-mode-hook 'my/shell/bash-completion)

(provide 'init-shell)
;;; init-shell.el ends here
