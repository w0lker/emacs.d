;;; package -- Yasnippet 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'yasnippet
  (defconst completion/yas-snippet-dirs (expand-file-name ".snippets" user-emacs-directory))
  (setq-default yas-snippet-dirs completion/yas-snippet-dirs)
  (add-to-list 'load-path completion/yas-snippet-dirs)
  (yas-global-mode t)
  (with-eval-after-load 'diminish
    (diminish 'yas-minor-mode)
    )
  )

(provide 'init-yasnippet)
;;;  init-yasnippet.el ends here
