;;; package -- 历史日志配置
;;; Commentary:
;;; Code:

;; 基本配置
(setq recentf-max-saved-items 2000
      recentf-save-file  (concat user-emacs-directory
                                 (file-name-as-directory my-temp-dir)
                                 "recentf") ;; 保存目录
      recentf-auto-cleanup 'never ;; 使用tramp模式的时候需要关闭，否则会判断文件的可访问性
      recentf-exclude '("/tmp/"))
(recentf-mode 1)

;; 每10分钟保存一次数据
;; (run-at-time nil (* 10 60) 'recentf-save-list)

;; 配置显示最近打开的文件
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(provide 'init-recentf)
;;;  init-recentf.el ends here
