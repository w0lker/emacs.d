;;; package -- sql配置
;;; Commentary:
;;; Code:

(require-package 'sql-indent)
(after-load 'sql
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

;; See my answer to https://emacs.stackexchange.com/questions/657/why-do-sql-mode-and-sql-interactive-mode-not-highlight-strings-the-same-way/673
(defun my/sql/font-lock-everything-in-sql-interactive-mode ()
  "."
  (unless (eq 'oracle sql-product)
    (sql-product-font-lock nil nil)))
(add-hook 'sql-interactive-mode-hook 'my/sql/font-lock-everything-in-sql-interactive-mode)

(after-load 'page-break-lines
  (push 'sql-mode page-break-lines-modes))

(provide 'init-sql)
;;;  init-sql.el ends here
