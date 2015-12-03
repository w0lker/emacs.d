(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-surround)

(setq evil-leader/leader ";"
      evil-leader/in-all-states t)

(evil-leader/set-key
  "q" 'evil-quit
  "f" 'find-file
  "d" 'find-dired
  "r" 'iedit-mode
  "b" 'ibuffer
  "k" 'kill-buffer
  "w" 'save-buffer ;; 保存当前缓冲区
  "g" 'goto-line ;; 到指定行
  "j" 'avy-goto-char ;; 跳到指定字符
  "p" 'md/duplicate-down ;; 复制当前行到下一行
  "n" 'editing/newline-at-end-of-line ;; 创建一个新行
  )

(global-evil-leader-mode)
(evil-mode 1)



(provide 'init-evil)
;;; init-evil.el 
