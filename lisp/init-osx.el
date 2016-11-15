;;; package -- 苹果配置
;;; Commentary:
;;; Code:

(defconst *is-a-mac* (eq system-type 'darwin))

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none)
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

;; 系统剪贴板快捷键
(when *is-a-mac*
  ;; 取消首字母大写快捷键M-c，设置为复制选中的内容到粘贴板
  (global-unset-key (kbd "M-c"))
  (global-set-key (kbd "M-c") 'clipboard-kill-ring-save)
  ;; 取消滚动到文档最下面的快捷键M-v，设置为粘贴系统粘贴板中的内容
  (global-unset-key (kbd "M-v"))
  (global-set-key (kbd "M-v") 'clipboard-yank)
  )

;; 使用C-M-f触发全屏模式
(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  (global-set-key (kbd "C-M-f") 'toggle-frame-fullscreen))

;; 设置默认查找命令
(when *is-a-mac*
  (setq-default locate-command "mdfind"))

;; 允许从特定的应用抽取URL和选中的内容拷贝到Org模式中
(when *is-a-mac*
  (with-eval-after-load 'org
    (require-package 'grab-mac-link)
    (add-hook 'org-mode-hook (lambda ()
                               (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link))))
   )

(provide 'init-osx)
;;;  init-osx.el ends here
