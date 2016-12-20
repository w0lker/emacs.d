;;; package -- 主题
;;; Commentary:
;;; Code:

(require-package 'molokai-theme)
(load-theme 'molokai t)

;; 美化 mode-line
(require-package 'smart-mode-line)
(require-package 'smart-mode-line-powerline-theme)
(setq sml/shorten-directory t)
(if (window-system) (setq sml/theme 'powerline) (setq sml/theme 'dark))
(setq sml/no-confirm-load-theme t)
(sml/setup)

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
