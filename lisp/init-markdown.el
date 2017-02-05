;;; package -- Markdown编辑
;;; Commentary:
;;; Code:

(config-after-fetch-require 'markdown-mode
  (add-to-list 'auto-mode-alist '("\\.\\(markdown\\|md\\)\\'" . markdown-mode))
  )

(provide 'init-markdown)
;;;  init-markdown.el ends here
