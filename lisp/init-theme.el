;;; package -- 主题配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'molokai-theme
  (load-theme 'molokai t)
  )

(config-after-fetch-require 'smart-mode-line
  (setq sml/no-confirm-load-theme t
	sml/shorten-directory t
	sml/shorten-modes t
	sml/hidden-modes nil
	sml/vc-mode-show-backend nil
	sml/theme 'dark
	)
  (sml/setup)
  )

;; 美化 mode-line 不显示边框
(set-face-attribute 'mode-line nil :box nil)

;; 不显示工具栏
(tool-bar-mode -1)

;; 不显示滚动条
(scroll-bar-mode -1)

;; 显示时间
(display-time-mode 1)

;; 显示列
(column-number-mode 1)

;; 控制台不显示菜单
(if (memq window-system '(ns x))
    (menu-bar-mode 1)
  (menu-bar-mode -1)
  )

;; 光标形状
(setq-default cursor-type '(bar . 2))

(provide 'init-theme)
;;;  init-theme.el ends here
