;;; package -- Go语言配置
;;; Commentary:
;;; Code:

(fetch-package 'go-mode)
(fetch-package 'company-go)
(fetch-package 'go-eldoc)

(require 'go-mode)
(with-eval-after-load 'go-mode
  (with-eval-after-load 'exec-path-from-shell
    (dolist (var '("GOPATH" "GOROOT"))
      (add-to-list 'exec-path-from-shell-variables var)))

  (add-hook 'go-mode-hook '(lambda ()
			     (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

  (add-hook 'go-mode-hook '(lambda ()
			     (local-set-key (kbd "C-c C-f") 'gofmt)))

  (with-eval-after-load 'company
    (require 'company-go)
    (add-hook 'go-mode-hook (lambda ()
			      (set (make-local-variable 'company-backends) '(company-go))))
    )

  (require 'go-eldoc)
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  )

(provide 'init-golang)
;;;  init-golang.el ends here
