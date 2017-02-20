;;; package -- Yasnippet 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'yasnippet
  (defconst yasnippet/snippet-dirs (expand-file-name "snippets" user-conf-dir))
  (add-to-list 'yas-snippet-dirs yasnippet/snippet-dirs)
  (setq yas-snippet-dirs (delete* (expand-file-name "snippets" user-emacs-directory) yas-snippet-dirs :test 'string=))
  (add-to-list 'load-path yasnippet/snippet-dirs)

  (yas-global-mode t)

  (config-after-fetch-require 'dropdown-list
    (setq yas-prompt-functions '(yas-dropdown-prompt
				 yas-completing-prompt
				 yas-maybe-ido-prompt
				 yas-no-prompt))
    )

  (with-eval-after-load 'diminish
    (diminish 'yas-minor-mode)
    )
  )

(provide 'init-yasnippet)
;;;  init-yasnippet.el ends here
