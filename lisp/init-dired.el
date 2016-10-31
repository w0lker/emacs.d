;;; package -- 文件管理工具dired+配置
;;; Commentary:
;;; Code:

;; 默认配置
(setq-default diredp-hide-details-initially-flag nil
              dired-dwim-target t)

;; 如果gnu的ls可用就使用
(let ((gls (executable-find "gls")))
  (when gls (setq insert-directory-program gls)))

(require-package 'dired+)
(require-package 'dired-sort)
(after-load 'dired
  (require 'dired+)
  (require 'dired-sort)
  (when (fboundp 'global-dired-hide-details-mode)
    (global-dired-hide-details-mode -1))
  (setq dired-recursive-deletes 'top)
  (define-key dired-mode-map [mouse-2] 'dired-find-file)
  ;; 添加通过%快捷键显示帮助
  (add-hook 'dired-mode-hook
            (lambda () (guide-key/add-local-guide-key-sequence "%"))))

;; 修改内容左侧提示
(when (maybe-require-package 'diff-hl)
  (after-load 'dired
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)))

(provide 'init-dired)
;;;  init-dired.el ends here
