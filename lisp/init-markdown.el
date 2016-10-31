;;; package -- markdown编辑
;;; Commentary:
;;; Code:

;; 配置关联文件
(add-auto-mode 'markdown-mode "\\.\\(markdown\\|md\\)\\'")

(require-package 'markdown-mode)

;; 如果启动了whitspace-cleanup-mode，则添加当前模式到忽略列表
(after-load 'whitespace-cleanup-mode
  (push 'markdown-mode whitespace-cleanup-mode-ignore-modes))

(provide 'init-markdown)
;;;  init-markdown.el ends here
