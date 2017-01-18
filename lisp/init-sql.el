;;; package -- SQL配置
;;; Commentary:
;;; Code:

(defconst sql-input-ring-file-name (concat user-temp-dir ".sqli_history"))

(use-package sql-indent :ensure t)

(defun sql/pop-to-sqli-buffer ()
  "Switch to the corresponding sqli buffer."
  (interactive)
  (if sql-buffer
      (progn
        (pop-to-buffer sql-buffer)
        (goto-char (point-max)))
    (sql-set-sqli-buffer)
    (when sql-buffer
      (sql/pop-to-sqli-buffer))))

(provide 'init-sql)
;;;  init-sql.el ends here
