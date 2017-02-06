;;; package -- Flycheck 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'flycheck
  (setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (config-after-fetch-require 'diminish
    (diminish 'flycheck-mode)
    )
  )

(provide 'init-flycheck)
;;;  init-flycheck.el ends here
