(when (maybe-require-package 'flycheck)
    (add-hook 'after-init-hook 'global-flycheck-mode)
    ;; 覆盖默认的配置
    (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.8)
    (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-listi))



(provide 'init-flycheck)
