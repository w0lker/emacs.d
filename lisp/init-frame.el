;;; package -- 窗口配置
;;; Commentary:
;;; Code:

(if (and (functionp 'menu-bar-mode)
	 (unless window-system))
    ;; 不显示菜单
    (menu-bar-mode -1))

(if (functionp 'tool-bar-mode)
    ;; 不显示工具栏
    (tool-bar-mode -1))

(if (fboundp 'scroll-bar-mode)
    ;; 不显示滚动条
    (scroll-bar-mode -1))

;; 无边框
(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

(config-after-require 'frame
  (defconst *is-frame* (memq window-system '(mac ns x)) "是否为桌面程序.")

  ;; 设置窗口标题格式
  (setq frame-title-format '(:eval (if (buffer-file-name) (abbreviate-file-name (buffer-file-name)) "%b")))

  (config-add-hook 'after-make-frame-functions
    ;; 如果不是窗口，隐藏当前 FRAME 菜单拦
    (with-selected-frame frame
      (unless window-system
	(set-frame-parameter nil 'menu-bar-lines 0)))
    )

  (config-add-hook 'after-make-console-frame-hooks
    ;; 控制台下 C-<方向键> 修复
    (let ((map (if (boundp 'input-decode-map) input-decode-map function-key-map)))
      (define-key map "\e[1;5A" [C-up])
      (define-key map "\e[1;5B" [C-down])
      (define-key map "\e[1;5C" [C-right])
      (define-key map "\e[1;5D" [C-left])
      (define-key map "\e[5A"   [C-up])
      (define-key map "\e[5B"   [C-down])
      (define-key map "\e[5C"   [C-right])
      (define-key map "\e[5D"   [C-left])
      )
    ;; 控制台下鼠标支持
    (xterm-mouse-mode 1)
    (if (fboundp 'mwheel-install)
	(mwheel-install)
      )
    )

  (config-bind-global-key (kbd "C-M-f")
    ;; 使用C-M-f触发全屏模式
    (if (fboundp 'toggle-frame-fullscreen)
	(toggle-frame-fullscreen)
      )
    )
  
  (config-bind-global-key (kbd "C-z")
    ;; 控制台下使用`C-z`暂停程序
    (unless window-system (suspend-frame))
    )
  
  )

(provide 'init-frame)
;;;  init-frame.el ends here
