;;; package -- Vim 快捷键
;;; Commentary:
;;; Code:

(require-package 'evil)
;; 默认启动状态为emacs，使用快捷键C-z切换其它状态
(setq-default evil-default-state 'normal)
(evil-mode 1)

;; 设置前缀键
(require-package 'evil-leader)
;; 关闭emacs
(evil-leader/set-key "q" 'kill-buffer)
;; 保存当前缓冲区
(evil-leader/set-key "w" 'save-buffer)
;; 显示行信息
(evil-leader/set-key "l" 'linum-mode)
(setq-default evil-leader/leader "\\")
(setq-default evil-leader/in-all-states t)
(global-evil-leader-mode)

;; 用来操作成对匹配的括号
(require-package 'evil-surround)
(global-evil-surround-mode 1)

(provide 'init-evil)
;;;  init-evil.el ends here
