;;; package -- theme config
;;; Commentary:
;;; Code:


(require-package 'molokai-theme)
(load-theme 'molokai t)


;; 美化mode-line
(require-package 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(sml/setup)


(provide 'init-themes)
;;;  init-themes.el ends here
