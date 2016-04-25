;; 记住已经访问过得历史文件

(recentf-mode 1)
(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/" "/ssh:"))


(provide 'init-recentf)
