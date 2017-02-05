;;; package -- Go语言配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'go-mode
  (defun go/config-base ()
    "基本配置."
    (add-hook 'before-save-hook 'gofmt-before-save)
    (local-set-key (kbd "M-.") 'godef-jump)
    (local-set-key (kbd "M-*") 'pop-tag-mark)
    (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
    )
  (add-hook 'go-mode-hook 'go/config-base)

  (with-eval-after-load 'company
    (config-after-fetch-require 'company-go
      (add-hook 'go-mode-hook (lambda ()
				(set (make-local-variable 'company-backends) '(company-go))))
      )
    )

  (config-after-fetch-require 'go-eldoc
    (add-hook 'go-mode-hook 'go-eldoc-setup)
    (diminish 'eldoc-mode)
    )
  )

(provide 'init-golang)
;;;  init-golang.el ends here
