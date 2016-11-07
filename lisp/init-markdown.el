;;; package -- Markdown编辑
;;; Commentary:
;;; Code:

;; 关联文件
(add-to-list 'auto-mode-alist '("\\.\\(markdown\\|md\\)\\'" . markdown-mode))

(require-package 'markdown-mode)

(provide 'init-markdown)
;;;  init-markdown.el ends here
