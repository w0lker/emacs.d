;;; package -- 代码检查
;;; Commentary:
;;; Code:

(require-package 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)
(setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)
;; 隐藏 modeline 提示
(with-eval-after-load 'flycheck (diminish 'flycheck-mode))

(provide 'init-code-check)
;;;  init-code-check.el ends here
