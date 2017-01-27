;;; package -- 文件管理配置
;;; Commentary:
;;; Code:

(fetch-package 'dired+)
(fetch-package 'dired-sort)
(fetch-package 'diff-hl)

;; 如果 gnu ls 可用就使用
(let ((gls (executable-find "gls")))
  (when gls
    (setq insert-directory-program gls)))

(setq dired-recursive-deletes 'top)
(setq dired-dwim-target t)

(with-eval-after-load 'dired
  (define-key dired-mode-map [mouse-2] 'dired-find-file)

  (require 'dired+)
  ;; 使用 快捷键 ( 触发详情和关闭文件详情
  (setq diredp-hide-details-initially-flag nil)
  (global-dired-hide-details-mode t)

  (require 'dired-sort)

  (require 'diff-hl)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)

  (with-eval-after-load 'guide-key
    (add-hook 'dired-mode-hook (lambda () (guide-key/add-local-guide-key-sequence "%"))))

  (with-eval-after-load 'evil
    (evil-set-initial-state 'dired-mode 'normal)))

(provide 'init-dired)
;;;  init-dired.el ends here
