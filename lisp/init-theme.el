;;; package -- 主题
;;; Commentary:
;;; Code:

(use-package molokai-theme
  :ensure t
  :config
  (load-theme 'molokai t)
  )

;; 美化 mode-line
(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/theme 'dark)
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
  :config
  (use-package smart-mode-line-powerline-theme
    :ensure t
    :if window-system
    :config
    (setq sml/theme 'powerline)
    )
  (sml/setup)
  )

(provide 'init-theme)
;;;  init-theme.el ends here
