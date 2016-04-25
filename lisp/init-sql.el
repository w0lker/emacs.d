;; sql编辑配置

(require-package 'sql-indent)
(after-load 'sql
  (require 'sql-indent))

(defun my/pop-to-sqli-buffer ()
  "Switch to the corresponding sqli buffer."
  (interactive)
  (if sql-buffer
      (progn
        (pop-to-buffer sql-buffer)
        (goto-char (point-max)))
    (sql-set-sqli-buffer)
    (when sql-buffer
      (my/pop-to-sqli-buffer))))

(after-load 'sql
  (define-key sql-mode-map (kbd "C-c C-z") 'my/pop-to-sqli-buffer)
  (add-hook 'sql-interactive-mode-hook 'my/never-indent)
  (when (package-installed-p 'dash-at-point)
    (defun my/maybe-set-dash-db-docset ()
      (when (eq sql-product 'postgres)
        (set (make-local-variable 'dash-at-point-docset) "psql")))

    (add-hook 'sql-mode-hook 'my/maybe-set-dash-db-docset)
    (add-hook 'sql-interactive-mode-hook 'my/maybe-set-dash-db-docset)
    (defadvice sql-set-product (after set-dash-docset activate)
      (my/maybe-set-dash-db-docset))))

(setq-default sql-input-ring-file-name
              (expand-file-name ".sqli_history" user-emacs-directory))

;; See my answer to https://emacs.stackexchange.com/questions/657/why-do-sql-mode-and-sql-interactive-mode-not-highlight-strings-the-same-way/673
(defun my/font-lock-everything-in-sql-interactive-mode ()
  (unless (eq 'oracle sql-product)
    (sql-product-font-lock nil nil)))
(add-hook 'sql-interactive-mode-hook 'my/font-lock-everything-in-sql-interactive-mode)


(after-load 'page-break-lines
  (push 'sql-mode page-break-lines-modes))

(provide 'init-sql)
