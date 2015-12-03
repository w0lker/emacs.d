(require-package 'markdown-mode)

(after-load 'whitespace-cleanup-mode
  (push 'markdown-mode whitespace-cleanup-mode-ignore-modes))

(add-auto-mode 'markdown-mode "\\.\\(text\\|markdown\\)\\'")

(provide 'init-markdown)
