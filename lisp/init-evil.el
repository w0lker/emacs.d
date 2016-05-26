;; 配置使用vim快捷键

(require-package 'evil)
(evil-mode 1)

;; 设置前缀键
(require-package 'evil-leader)
(setq evil-leader/leader "\\"
      evil-leader/in-all-states t)

(evil-leader/set-key
  "q" 'save-buffers-kill-terminal ;; 关闭emacs
  "w" 'save-buffer ;; 保存当前缓冲区
  "f" 'find-file
  "d" 'find-dired ;; minibuffer中查找文件
  "y" 'my/pbcopy ;; 拷贝到系统剪切板
  "p" 'my/pbpaste
  "x" 'my/pbcut
  "r" 'iedit-mode
  "g" 'goto-line ;; 到指定行
  "j" 'avy-goto-char ;; 跳到指定字符
  "p" 'md/duplicate-down ;; 复制当前行到下一行
  "l" 'linum-mode ;; 显示行信息
  )

(global-evil-leader-mode)


(provide 'init-evil)
