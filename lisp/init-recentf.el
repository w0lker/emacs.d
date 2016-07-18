;; 记住已经访问过得历史文件

(recentf-mode 1)
(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/"))

;; 使用tramp模式的时候需要关闭，否则会判断文件的可访问性
(setq recentf-auto-cleanup 'never)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(provide 'init-recentf)
