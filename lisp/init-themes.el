;;; package -- theme config
;;; Commentary:
;;; Code:


;; Configure theme
(require-package 'molokai-theme)
(load-theme 'molokai t)


;; Beautiful mode-line
(require-package 'smart-mode-line)
(setq sml/shorten-directory t)
(setq sml/theme 'respectful)
(setq sml/no-confirm-load-theme t)
(sml/setup)


(provide 'init-themes)
;;;  init-themes.el ends here
