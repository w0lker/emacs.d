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

(set-face-attribute 'mode-line nil :box nil)

;; 显示时间
(display-time-mode 1)

(provide 'init-theme)
;;;  init-theme.el ends here
