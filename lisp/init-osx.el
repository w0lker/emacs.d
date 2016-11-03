;;; package -- 苹果配置
;;; Commentary:
;;; Code:

(defconst *is-a-mac* (eq system-type 'darwin))

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none)
  (setq-default default-input-method "MacOSX")
  ;; 减慢鼠标的滚动速度
  (setq mouse-wheel-scroll-amount '(1
                                    ((shift) . 5)
                                    ((control))))
  (dolist (multiple '("" "double-" "triple-"))
    (dolist (direction '("right" "left"))
      (global-set-key (read-kbd-macro (concat "<" multiple "wheel-" direction ">")) 'ignore)))
  (global-set-key (kbd "M-`") 'ns-next-frame) ;; 显示下一个frame
  (global-set-key (kbd "M-h") 'ns-do-hide-emacs) ;; 隐藏emacs
  )

;; 使用C-M-f触发全屏模式
(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  (global-set-key (kbd "C-M-f") 'toggle-frame-fullscreen))

;; 设置默认查找使用命令
(when *is-a-mac*
  (setq-default locate-command "mdfind"))

(provide 'init-osx)
;;;  init-osx.el ends here
