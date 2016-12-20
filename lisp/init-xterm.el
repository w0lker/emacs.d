;;; package -- 控制台配置
;;; Commentary:
;;; Code:

;; 环境变量
(setenv "TERM" "xterm-256color")

;; 修复按键映射
(defun fix-up-xterm-control-arrows ()
  "Keys mapping."
  (let ((map (if (boundp 'input-decode-map) input-decode-map function-key-map)))
    (define-key map "\e[1;5A" [C-up])
    (define-key map "\e[1;5B" [C-down])
    (define-key map "\e[1;5C" [C-right])
    (define-key map "\e[1;5D" [C-left])
    (define-key map "\e[5A"   [C-up])
    (define-key map "\e[5B"   [C-down])
    (define-key map "\e[5C"   [C-right])
    (define-key map "\e[5D"   [C-left])))
(add-hook 'after-make-console-frame-hooks 'fix-up-xterm-control-arrows)

(global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
(global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))

;; 添加控制台下鼠标支持 (Use shift to paste with middle button)
(defun my/xterm/console-frame-setup ()
  "Mouse support."
  (xterm-mouse-mode 1)
  (when (fboundp 'mwheel-install)
    (mwheel-install)))
(add-hook 'after-make-console-frame-hooks 'my/xterm/console-frame-setup)

(provide 'init-xterm)
;;;  init-xterm.el ends here
