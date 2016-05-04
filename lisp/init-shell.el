;;; package --- shell-mode配置
;;; Commentary:
;;; Code:

;; 清屏操作
(defun my/clear-shell ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
(global-set-key (kbd "C-c l") 'my/clear-shell)

(defun my-filter (condp lst)
  "Filter match CONDP condition function element from LST."
  (delq nil (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun shell-dwim (&optional create)
  "Start or switch to an inferior shell process, in a smart way.
If a buffer with a running shell process exists, simply switch to that buffer.
If a shell buffer exists, but the shell process is not running, restart the
shell.  If already in an active shell buffer, switch to the next one, if
any.  With prefix argument CREATE always start a new shell."
  (interactive "P")
  (let ((next-shell-buffer) (buffer)
        (shell-buf-list (identity ;;used to be reverse
                         (sort
                          (my-filter (lambda (x) (string-match "^\\*shell\\*" (buffer-name x))) (buffer-list))
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

(add-hook 'shell-mode-hook
          (function (lambda ()
                      (setq comint-prompt-read-only t) ;提示符只读
                      ;; 配置颜色
                      (require-package 'xterm-color)
                      (setenv "TERM" "xterm-256color")
                      ;; 配置补全
                      (require-package 'bash-completion)
                      (bash-completion-setup)
                      )))

(provide 'init-shell)
;;; init-shell.el ends here
