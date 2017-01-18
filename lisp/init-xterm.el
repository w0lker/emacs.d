;;; package -- 控制台配置
;;; Commentary:
;;; Code:

;; 环境变量
(setenv "TERM" "xterm-256color")

;; 修复按键映射
(defun xterm/fix-up-control-arrows ()
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
(add-hook 'after-make-console-frame-hooks 'xterm/fix-up-control-arrows)

(defun xterm/mouse-support ()
  "控制台下鼠标支持."
  (xterm-mouse-mode 1)
  (when (fboundp 'mwheel-install)
    (mwheel-install)))
(add-hook 'after-make-console-frame-hooks 'xterm/mouse-support)

(provide 'init-xterm)
;;;  init-xterm.el ends here
