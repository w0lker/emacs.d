;;; package -- SQL配置
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.hql\\'" . sql-mode))

(setq-default sql-input-ring-file-name (concat user-temp-dir ".sqli_history"))

(config-after-fetch-require 'sql-indent)

(provide 'init-sql)
;;;  init-sql.el ends here
