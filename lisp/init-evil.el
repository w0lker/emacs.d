;;; package -- Vim快捷键
;;; Commentary:
;;; Code:

(require-package 'evil)
(evil-mode 1)

;; 默认启动状态为emacs，使用快捷键C-z切换其它状态
(setq evil-default-state 'normal)

;; 设置前缀键
(require-package 'evil-leader)
(setq evil-leader/leader "\\"
      evil-leader/in-all-states t)

(evil-leader/set-key
  "b" 'ibuffer ;;启动ibuffer
  "l" 'linum-mode ;; 显示行信息
  "q" 'kill-buffer ;; 关闭emacs
  "w" 'save-buffer ;; 保存当前缓冲区
  )
(global-evil-leader-mode)

;; 用来操作成对匹配的括号
(require-package 'evil-surround)
(global-evil-surround-mode 1)

(provide 'init-evil)
;;;  init-evil.el ends here
