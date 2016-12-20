;;; package -- Grep 查找
;;; Commentary:
;;; Code:

;; 文档查找, 可以随时使用M-?查找当前目录和其子目录下包含特点文本的所有文件
(setq-default grep-highlight-matches t)
(setq-default grep-scroll-output t)

(require-package 'ag)
(require-package 'wgrep-ag)
;; 使用ag查找命令
(when (executable-find "ag")
  (setq-default ag-highlight-search t)
  (global-set-key (kbd "M-?") 'ag-project))

(provide 'init-grep)
;;;  init-grep.el ends here
