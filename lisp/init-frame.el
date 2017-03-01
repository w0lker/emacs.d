;;; package -- 窗口配置
;;; Commentary:
;;; Code:

(with-eval-after-load 'frame
  (defconst *is-frame* (memq window-system '(ns x)) "如果是桌面程序则为t.")

  ;; 无边框
  (let ((no-border '(internal-border-width . 0)))
    (add-to-list 'default-frame-alist no-border)
    (add-to-list 'initial-frame-alist no-border)
    )

  ;; 设置窗口标题格式
  (setq frame-title-format '(:eval (if (buffer-file-name) (abbreviate-file-name (buffer-file-name)) "%b")))

  (if *is-frame*
      ;; 设置默认字体
      (if (eq system-type 'darwin)
	  (progn
	    (add-to-list 'default-frame-alist '(font . "Menlo-11"))
	    (set-fontset-font "fontset-default" 'han '("STHeiti"))
	    )
	)
    )

  (config-after-fetch-require 'default-text-scale
    ;; 字体大小调整
    (when (memq window-system '(ns x))
      (global-set-key (kbd "C-M-=") 'default-text-scale-increase)
      (global-set-key (kbd "C-M--") 'default-text-scale-decrease)
      (config-add-hook 'visual-fill-column-mode-hook
	;; 自动适配列数
	(if visual-fill-column-mode
	    (add-hook 'after-setting-font-hook 'visual-fill-column--adjust-window nil t)
	  (remove-hook 'after-setting-font-hook 'visual-fill-column--adjust-window t)
	  )
	)
      )
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
