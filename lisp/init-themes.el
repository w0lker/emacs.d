(require-package 'molokai-theme)
(setq molokai-theme-kit t)
(load-theme 'molokai t)

;; 美化mode-line
(require-package 'powerline)
(require-package 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(sml/setup)

(provide 'init-themes)
