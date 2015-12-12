(require-package 'evil)
(require 'evil)

(require-package 'evil-leader)
(require 'evil-leader)
(setq evil-leader/leader ";"
      evil-leader/in-all-states t)

(evil-leader/set-key
  "q" 'kill-this-buffer
  "f" 'find-file
  "d" 'find-dired
  "r" 'iedit-mode
  "b" 'ibuffer
  "w" 'save-buffer ;; 保存当前缓冲区
  "g" 'goto-line ;; 到指定行
  "j" 'avy-goto-char ;; 跳到指定字符
  "J" 'semantic-ia-fast-jump ;; 跳到代码的定义处
  "t" 'ff-find-related-file ;; 在头文件和源码之间切换
  "p" 'md/duplicate-down ;; 复制当前行到下一行
  "l" 'linum-mode ;; 显示行信息
  )

(global-evil-leader-mode)
(evil-mode 1)

(provide 'init-evil)
