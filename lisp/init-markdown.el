;;; package -- markdown编辑
;;; Commentary:
;;; Code:

;; 关联文件
(setq auto-mode-alist
      (append '(("\\.\\(markdown\\|md\\)\\'" . python-mode))
              auto-mode-alist))

(require-package 'markdown-mode)

(provide 'init-markdown)
;;;  init-markdown.el ends here
