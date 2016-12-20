;;; package -- 文件管理配置
;;; Commentary:
;;; Code:

(setq-default diredp-hide-details-initially-flag nil)
(setq-default dired-dwim-target t)

;; 如果gnu的 ls 可用就使用
(let ((gls (executable-find "gls"))) (when gls (setq insert-directory-program gls)))

(require-package 'dired+)
(require-package 'dired-sort)
(with-eval-after-load 'dired
  (require 'dired+)
  (require 'dired-sort)
  (when (fboundp 'global-dired-hide-details-mode) (global-dired-hide-details-mode -1))
  (setq dired-recursive-deletes 'top)
  (define-key dired-mode-map [mouse-2] 'dired-find-file))

;; 添加通过 % 快捷键显示帮助，？ 快捷键是 dired 使用的帮助快捷键
(with-eval-after-load 'guide-key
  (add-hook 'dired-mode-hook (lambda () (guide-key/add-local-guide-key-sequence "%"))))

;; 左侧提示 diff 内容
(require-package 'diff-hl)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

;; 配置 Vim 快捷键
(with-eval-after-load 'dired
  (when (functionp 'evil-set-initial-state)
    (evil-set-initial-state 'dired-mode 'normal)))

(provide 'init-dired)
;;;  init-dired.el ends here
