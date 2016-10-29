;;; package -- 苹果键盘配置
;;; Commentary:
;;; Code:

(when *is-a-mac*
  (setq-default default-input-method "MacOSX")
  ;; 减慢鼠标的滚动速度
  (setq mouse-wheel-scroll-amount '(1
                                    ((shift) . 5)
                                    ((control))))
  (dolist (multiple '("" "double-" "triple-"))
    (dolist (direction '("right" "left"))
      (global-set-key (read-kbd-macro (concat "<" multiple "wheel-" direction ">")) 'ignore)))
  (global-set-key (kbd "M-`") 'ns-next-frame)
  (global-set-key (kbd "M-˙") 'ns-do-hide-others)
  (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
  ;; 解决M-h与nxml-mode冲突
  (after-load 'nxml-mode
    (define-key nxml-mode-map (kbd "M-h") nil))
  (global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports for cmd-option-h
  )

(provide 'init-osx-keys)
;;;  init-osx-keys.el ends here
