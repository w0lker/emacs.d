;;; package -- 代码检查
;;; Commentary:
;;; Code:

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init
  (setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  )

(provide 'init-code-check)
;;;  init-code-check.el ends here
