;;; package -- 文件管理配置
;;; Commentary:
;;; Code:

(fetch-package 'dired+)
(fetch-package 'dired-sort)
(fetch-package 'diff-hl)

;; 如果gnu的 ls 可用就使用
(let ((gls (executable-find "gls"))) (when gls (setq insert-directory-program gls)))

(with-eval-after-load 'dired
  (require 'dired+)
  (require 'dired-sort)

  (when (fboundp 'global-dired-hide-details-mode)
    (global-dired-hide-details-mode -1))

  (setq dired-recursive-deletes 'top)
  (setq-default dired-dwim-target t)
  (setq-default diredp-hide-details-initially-flag nil)
  (define-key dired-mode-map [mouse-2] 'dired-find-file)

  (require 'diff-hl)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)

  (with-eval-after-load 'guide-key
    (add-hook 'dired-mode-hook (lambda () (guide-key/add-local-guide-key-sequence "%"))))

  (with-eval-after-load 'evil
    (evil-set-initial-state 'dired-mode 'normal))
  )

(provide 'init-dired)
;;;  init-dired.el ends here
