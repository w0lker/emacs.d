;;; package -- 文件管理配置
;;; Commentary:
;;; Code:

;; 如果gnu的 ls 可用就使用
(let ((gls (executable-find "gls"))) (when gls (setq insert-directory-program gls)))

(use-package dired
  :demand t
  :bind (:map dired-mode-map
	      ([mouse-2] . dired-find-file))
  :init
  (setq dired-recursive-deletes 'top)
  (setq-default dired-dwim-target t)
  :config
  (use-package dired+
    :ensure t
    :demand t
    :init
    (setq-default diredp-hide-details-initially-flag nil)
    :config
    (global-dired-hide-details-mode -1)
    )

  (use-package dired-sort
    :ensure t
    :demand t
    )

  ;; 左侧提示 diff 内容
  (use-package diff-hl
    :ensure t
    :config
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
    )

  (use-package guide-key
    :ensure t
    :config
    ;; 添加通过 % 快捷键显示帮助，？ 快捷键是 dired 使用的帮助快捷键
    (add-hook 'dired-mode-hook (lambda () (guide-key/add-local-guide-key-sequence "%"))))

  (use-package evil
    :ensure t
    :config
    (evil-set-initial-state 'dired-mode 'normal))
  )

(provide 'init-dired)
;;;  init-dired.el ends here
