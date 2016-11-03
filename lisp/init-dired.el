;;; package -- 文件管理工具dired+配置
;;; Commentary:
;;; Code:

;; 默认配置
(setq-default diredp-hide-details-initially-flag nil
              dired-dwim-target t)

;; 如果gnu的ls可用就使用
(let ((gls (executable-find "gls")))
  (when gls (setq insert-directory-program gls)))

(with-eval-after-load 'dired
  (require-package 'dired+)
  (require 'dired+)
  (require-package 'dired-sort)
  (require 'dired-sort)
  (when (fboundp 'global-dired-hide-details-mode)
    (global-dired-hide-details-mode -1))
  (setq dired-recursive-deletes 'top)
  (define-key dired-mode-map [mouse-2] 'dired-find-file)
  ;; 添加通过%快捷键显示帮助，？快捷键是dired使用的帮助快捷键
  (add-hook 'dired-mode-hook
            (lambda () (guide-key/add-local-guide-key-sequence "%"))))

;; 内容diff左侧提示
(with-eval-after-load 'dired
  (when (require-package 'diff-hl)
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)))

;; 配置Vim快捷键
(with-eval-after-load 'dired
  (when (functionp 'evil-set-initial-state)
    (evil-set-initial-state 'dired-mode 'normal))
  )

(provide 'init-dired)
;;;  init-dired.el ends here
