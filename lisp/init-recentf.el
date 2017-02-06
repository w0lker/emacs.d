;;; package -- 最近文件配置
;;; Commentary:
;;; Code:

(config-after-require 'recentf
  (setq recentf-max-saved-items 2000)
  (setq recentf-auto-cleanup 'never) ;; 使用tramp模式的时候需要关闭，否则会判断文件的可访问性
  (setq-default recentf-save-file  (concat user-temp-dir "recentf")) ;; 保存目录
  (setq-default recentf-exclude '("/tmp/" "\\.emacs\\.d/temp/"))
  (recentf-mode t)
  (global-set-key (kbd "C-x C-r") 'recentf-open-files)
  )

(provide 'init-recentf)
;;;  init-recentf.el ends here
