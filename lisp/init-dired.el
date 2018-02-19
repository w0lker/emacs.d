;;; package -- Dired 配置
;;; Commentary:
;;; Code:

(with-eval-after-load 'dired

  (setq dired-recursive-deletes 'top
        dired-dwim-target t)

  (define-key dired-mode-map [mouse-2] 'dired-find-file)

  (with-eval-after-load 'files
    ;; 如果 gnu ls 可用就使用
    (let ((gls (executable-find "gls")))
      (when gls
        (setq insert-directory-program gls)
        )
      )
    )

  (config-after-fetch-require 'diredfl
    (diredfl-global-mode)
    )

  (config-after-fetch-require 'diff-hl
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
    )

  (with-eval-after-load 'guide-key
    (add-hook 'dired-mode-hook (lambda () (guide-key/add-local-guide-key-sequence "%")))
    )

  (with-eval-after-load 'evil
    (evil-set-initial-state 'dired-mode 'emacs)
    )
  )

(provide 'init-dired)
;;;  init-dired.el ends here
