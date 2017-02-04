;;; package -- Go语言配置
;;; Commentary:
;;; Code:

(fetch-package 'go-mode)
(fetch-package 'company-go)

(require 'go-mode)

(add-hook 'go-mode-hook '(lambda ()
			   (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook '(lambda ()
			   (local-set-key (kbd "C-c C-f") 'gofmt)))

(require 'go-mode)
(with-eval-after-load 'company
  (require 'company-go)
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))))
  )

(provide 'init-golang)
;;;  init-golang.el ends here
