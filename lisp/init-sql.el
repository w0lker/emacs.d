;;; package -- SQL配置
;;; Commentary:
;;; Code:

(require-package 'sql-indent)
(with-eval-after-load 'sql
  (require 'sql-indent))

(defun my/sql/pop-to-sqli-buffer ()
  "Switch to the corresponding sqli buffer."
  (interactive)
  (if sql-buffer
      (progn
        (pop-to-buffer sql-buffer)
        (goto-char (point-max)))
    (sql-set-sqli-buffer)
    (when sql-buffer
      (my/sql/pop-to-sqli-buffer))))

(setq-default sql-input-ring-file-name
              (expand-file-name ".sqli_history" user-emacs-directory))

(provide 'init-sql)
;;;  init-sql.el ends here
