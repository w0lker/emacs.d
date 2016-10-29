;;; package -- 图形界面配置
;;; Commentary:
;;; Code:

;; 除了mac和windows之外使用C-z可以暂停当前窗口
(defun my/maybe-suspend-frame ()
  "Suspend frame when using `C-z`."
  (interactive)
  (unless (and *is-a-mac* window-system)
    (suspend-frame)))
(global-set-key (kbd "C-z") 'my/maybe-suspend-frame)

;; 禁止图形特性
(setq use-file-dialog nil)
(setq use-dialog-box nil)
;; 隐藏启动画面
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;; 在文件结尾通过横杠指示文件结束
;; 可以通过M-x toggle-indicate-empty-lines关闭或者打开
(setq indicate-empty-lines t)

;; 取消工具栏
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; 无边框
(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

;; 全屏模式
(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  ;; Command-Shift-f to toggle fullscreen mode
  ;; Hint: Customize `ns-use-native-fullscreen'
  (global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen))

;; 隐藏选中的窗口的菜单栏
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (unless window-system
                (set-frame-parameter nil 'menu-bar-lines 0)))))

;; 设置窗口标题格式
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Non-zero values for `line-spacing' can mess up ansi-term and co,
;; so we zero it explicitly in those cases.
(add-hook 'term-mode-hook
          (lambda ()
            (setq line-spacing 0)))

;; 不使用鼠标
(require-package 'disable-mouse)

(provide 'init-gui-frames)
;;;  init-gui-frames.el ends here
