;;; package -- 苹果配置
;;; Commentary:
;;; Code:

(defconst *is-a-mac* (eq system-type 'darwin))

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta)
  )

;; 使用C-M-f触发全屏模式
(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  (global-set-key (kbd "C-M-f") 'toggle-frame-fullscreen))

(provide 'init-mac)
;;;  init-mac.el ends here
