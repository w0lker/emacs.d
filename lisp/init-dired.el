;;; package -- Dired 配置
;;; Commentary:
;;; Code:

(with-eval-after-load 'dired
  (with-eval-after-load 'files
    ;; 如果 gnu ls 可用就使用
    (let ((gls (executable-find "gls")))
      (when gls
	(setq insert-directory-program gls)))
    )

  (setq dired-recursive-deletes 'top
	dired-dwim-target t
	)
  (define-key dired-mode-map [mouse-2] 'dired-find-file)

  (config-after-fetch-require 'dired+
    ;; 使用快捷键 ( 触发详情和关闭文件详情
    (setq diredp-hide-details-initially-flag nil)
    (global-dired-hide-details-mode t)
    )

  (config-after-fetch-require 'dired-sort)

  (config-after-fetch-require 'diff-hl
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
    )

  (with-eval-after-load 'guide-key
    (add-hook 'dired-mode-hook (lambda () (guide-key/add-local-guide-key-sequence "%")))
    )

  (with-eval-after-load 'evil
    (evil-set-initial-state 'dired-mode 'emacs))
  )

(provide 'init-dired)
;;;  init-dired.el ends here
