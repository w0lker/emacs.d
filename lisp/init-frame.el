;;; package -- 窗口设置
;;; Commentary:
;;; Code:

(defconst *is-frame* (memq window-system '(mac ns x)))

;; 除了mac和windows之外使用C-z可以暂停当前窗口
(defun frame/maybe-suspend-frame ()
  "Suspend frame when using `C-z`."
  (interactive)
  (unless window-system (suspend-frame)))
(global-set-key (kbd "C-z") 'frame/maybe-suspend-frame)

;; 禁止图形特性
(setq use-file-dialog nil)
(setq use-dialog-box nil)

;; 隐藏启动画面
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;; scratch默认不显示任何内容
(setq initial-scratch-message nil)

;; 控制不显示工具栏
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
;; 不显示菜单
(if (and (functionp 'menu-bar-mode)(not window-system)) (menu-bar-mode -1))
;; 不显示滚动条
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; 无边框
(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

;; 隐藏选中的窗口的菜单栏
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (unless window-system
                (set-frame-parameter nil 'menu-bar-lines 0)))))

;; 鼠标滚动平滑
(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1)
  )

;; 设置窗口标题格式
(setq frame-title-format '((:eval (if (buffer-file-name) (abbreviate-file-name (buffer-file-name)) "%b"))))

;; 同步emacs的环境变量和shell的环境变量
(use-package exec-path-from-shell
  :ensure t
  :if *is-frame*
  :config
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize)
  )

(provide 'init-frame)
;;;  init-frame.el ends here
