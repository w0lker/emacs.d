;;; package -- Markdown编辑
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.\\(markdown\\|md\\)\\'" . markdown-mode))

(config-after-fetch-require 'markdown-mode)

(provide 'init-markdown)
;;;  init-markdown.el ends here
