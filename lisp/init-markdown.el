;;; package -- Markdown编辑
;;; Commentary:
;;; Code:

(fetch-package 'markdown-mode)

(add-to-list 'auto-mode-alist '("\\.\\(markdown\\|md\\)\\'" . markdown-mode))

(require 'markdown-mode)

(provide 'init-markdown)
;;;  init-markdown.el ends here
