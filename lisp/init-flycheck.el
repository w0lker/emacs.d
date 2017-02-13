;;; package -- Flycheck 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'flycheck
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)
  (with-eval-after-load 'diminish
    (diminish 'flycheck-mode)
    )
  )

(provide 'init-flycheck)
;;;  init-flycheck.el ends here
