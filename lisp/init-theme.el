;;; package -- 主题
;;; Commentary:
;;; Code:

(require-package 'molokai-theme)
(load-theme 'molokai t)

;; Beautiful mode-line
(require-package 'smart-mode-line)
(require-package 'smart-mode-line-powerline-theme)
(setq sml/shorten-directory t)
(if (window-system)
    (setq sml/theme 'powerline) (setq sml/theme 'dark))
(setq sml/no-confirm-load-theme t)
(sml/setup)

(provide 'init-theme)
;;;  init-theme.el ends here
