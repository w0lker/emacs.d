;;; package -- theme config
;;; Commentary:
;;; Code:


;; Configure theme
(require-package 'molokai-theme)
(load-theme 'molokai)


;; Beautiful mode-line
(require-package 'smart-mode-line)
(setq sml/shorten-directory t)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'dark)
(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^:Git:\(.*\)/src/main/java/" ":G/\1/SMJ:") t)


(provide 'init-themes)
;;;  init-themes.el ends here
