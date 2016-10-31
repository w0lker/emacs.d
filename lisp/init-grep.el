;;; package -- Grep查找
;;; Commentary:
;;; Code:

;; 文档查找, 可以随时使用M-?查找当前目录和其子目录下包含特点文本的所有文件
(setq-default grep-highlight-matches t
              grep-scroll-output t)

;; 使用ag查找命令
(when (executable-find "ag")
  (require-package 'ag)
  (require-package 'wgrep-ag)
  (setq-default ag-highlight-search t)
  (global-set-key (kbd "M-?") 'ag-project))

(provide 'init-grep)
;;;  init-grep.el ends here
