;; 配置xterm

(defun fix-up-xterm-control-arrows ()
  (let ((map (if (boundp 'input-decode-map)
                 input-decode-map
               function-key-map)))
    (define-key map "\e[1;5A" [C-up])
    (define-key map "\e[1;5B" [C-down])
    (define-key map "\e[1;5C" [C-right])
    (define-key map "\e[1;5D" [C-left])
    (define-key map "\e[5A"   [C-up])
    (define-key map "\e[5B"   [C-down])
    (define-key map "\e[5C"   [C-right])
    (define-key map "\e[5D"   [C-left])))

(global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
(global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))

(defun my/console-frame-setup ()
  (xterm-mouse-mode 1) ; 添加控制台下鼠标支持 (Use shift to paste with middle button)
  (when (fboundp 'mwheel-install)
    (mwheel-install)))

(add-hook 'after-make-console-frame-hooks 'my/console-frame-setup)

(provide 'init-xterm)
