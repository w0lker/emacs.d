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
  (global-set-key (kbd "M-`") 'ns-next-frame)
  (global-set-key (kbd "M-˙") 'ns-do-hide-others)
  (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
  ;; 解决M-h与nxml-mode冲突
  (after-load 'nxml-mode
    (define-key nxml-mode-map (kbd "M-h") nil))
  (global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports for cmd-option-h
  )

;; 全屏模式
(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  ;; Command-Shift-f to toggle fullscreen mode
  ;; Hint: Customize `ns-use-native-fullscreen'
  (global-set-key (kbd "C-M-f") 'toggle-frame-fullscreen))

;; 设置默认查找使用命令
(when *is-a-mac*
  (setq-default locate-command "mdfind"))

(provide 'init-osx)
;;;  init-osx.el ends here
