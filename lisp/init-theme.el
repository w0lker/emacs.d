;;; package -- 主题
;;; Commentary:
;;; Code:

;; 美化 mode-line
(require-package 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(setq sml/shorten-directory t)
(setq sml/shorten-modes t)
(setq sml/vc-mode-show-backend t) ;; 是否显示使用的版本控制工具
(custom-set-faces
 '(sml/modes ((t :foreground "#202000")))
 '(sml/prefix ((t :foreground "#d83b5d")))
 '(sml/folder ((t :foreground "#99cc66")))
 '(sml/filename ((t :foreground "#99cc66")))
 '(sml/process ((t :foreground "#99cc66")))
 '(sml/vc ((t :foreground "#92e56d")))
 '(sml/vc-edited ((t :foreground "#203c04")))
 '(sml/minor-modes ((t :foreground "#99cc66"))))

(require-package 'smart-mode-line-powerline-theme)
(if (window-system) (setq sml/theme 'powerline) (setq sml/theme 'dark))
(sml/setup)

(require-package 'molokai-theme)
(load-theme 'molokai t)

;; 设置默认字体
(set-default-font "Menlo 11")

;; 调整字体大小
(require-package 'default-text-scale)
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

(defun my/maybe-adjust-visual-fill-column ()
  "自动适配列数."
  (if visual-fill-column-mode
      (add-hook 'after-setting-font-hook 'visual-fill-column--adjust-window nil t)
    (remove-hook 'after-setting-font-hook 'visual-fill-column--adjust-window t)))
(add-hook 'visual-fill-column-mode-hook 'my/maybe-adjust-visual-fill-column)

(provide 'init-theme)
;;;  init-theme.el ends here
