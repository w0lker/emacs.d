;;; package -- 代码检查
;;; Commentary:
;;; Code:

(fetch-package 'flycheck)

(require 'flycheck)
(setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)
(add-hook 'after-init-hook 'global-flycheck-mode)
(diminish 'flycheck-mode)

(provide 'init-code-check)
;;;  init-code-check.el ends here
