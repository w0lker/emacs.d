;; 配置使用vim快捷键

(require-package 'evil)
(evil-mode 1)

;; 设置前缀键
(require-package 'evil-leader)
(setq evil-leader/leader "\\"
      evil-leader/in-all-states t)

(evil-leader/set-key
  "b" 'ibuffer ;;启动ibuffer
  "d" 'find-dired ;; minibuffer中查找文件
  "f" 'find-file ;; 查找文件
  "g" 'goto-line ;; 到指定行
  "j" 'avy-goto-char ;; 跳到指定字符
  "l" 'linum-mode ;; 显示行信息
  "p" 'my/pbpaste ;; 从系统剪切板粘贴
  "q" 'kill-buffer ;; 关闭emacs
  "r" 'iedit-mode ;; 替换文件
  "w" 'save-buffer ;; 保存当前缓冲区
  "x" 'my/pbcut ;; 剪切
  "y" 'my/pbcopy ;; 拷贝到系统剪切板
  )

(global-evil-leader-mode)


(provide 'init-evil)
