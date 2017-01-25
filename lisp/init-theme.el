;;; package -- 主题
;;; Commentary:
;;; Code:

(fetch-package 'molokai-theme)
(fetch-package 'smart-mode-line)
(fetch-package 'smart-mode-line-powerline-theme)

(require 'molokai-theme)
(load-theme 'molokai t)

(require 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(setq sml/shorten-directory t)
(setq sml/shorten-modes t)
(setq sml/vc-mode-show-backend t)

(custom-set-faces
 '(sml/modes ((t :foreground "#202000")))
 '(sml/prefix ((t :foreground "#d83b5d")))
 '(sml/folder ((t :foreground "#99cc66")))
 '(sml/filename ((t :foreground "#99cc66")))
 '(sml/process ((t :foreground "#99cc66")))
 '(sml/vc ((t :foreground "#92e56d")))
 '(sml/vc-edited ((t :foreground "#203c04")))
 '(sml/minor-modes ((t :foreground "#99cc66"))))

(require 'smart-mode-line-powerline-theme)
(if window-system
    (setq sml/theme 'powerline)
  (setq sml/theme 'dark))

(sml/setup)

(provide 'init-theme)
;;;  init-theme.el ends here
