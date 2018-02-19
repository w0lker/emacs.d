;;; package -- Go语言配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'go-mode

  (config-add-hook 'go-mode-hook
    (add-hook 'before-save-hook 'gofmt-before-save)
    (local-set-key (kbd "C-c C-.") 'godef-jump)
    (local-set-key (kbd "C-c C-*") 'pop-tag-mark)
    (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)

    (config-after-fetch-require 'company-go
      (company/add-buffer-local-backend 'company-go)
      )

    (config-after-fetch-require 'go-eldoc
      (go-eldoc-setup)
      (with-eval-after-load 'diminish
        (diminish 'eldoc-mode)
        )
      )

    (with-eval-after-load 'projectile
      (config-add-hook 'projectile-after-switch-project-hook
        (go-set-project)
        )
      )

    (with-eval-after-load 'yasnippet
      (yasnippet/add-buffer-local-company-backend)
      )
    )
  )

(provide 'init-golang)

;; Local Variables:
;; coding: utf-8
;; End:

;;; init-golang.el ends here
