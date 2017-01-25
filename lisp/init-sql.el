;;; package -- SQL配置
;;; Commentary:
;;; Code:

(fetch-package 'sql-indent)

(add-to-list 'auto-mode-alist '("\\.hql\\'" . sql-mode))

(defconst sql-input-ring-file-name (concat user-temp-dir ".sqli_history"))

(require 'sql-indent)

(provide 'init-sql)
;;;  init-sql.el ends here
