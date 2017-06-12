;;; package -- 最近文件配置
;;; Commentary:
;;; Code:

(config-after-require 'recentf
  (setq-default recentf-exclude '("/tmp/" "\\.emacs\\.d/temp/"))
  (setq recentf-max-saved-items 200
	recentf-max-menu-items 9
	recentf-auto-cleanup 'never ;; 使用tramp模式的时候需要关闭，否则会判断文件的可访问性
	recentf-save-file (concat user-temp-dir "recentf") ;; 保存目录
	)

  ;; 当一个buffer关联的文件被删除后，从recentf中删除这个buffer条目
  (defsubst file-was-visible-p (file)
    "如果FILE的缓冲区存在并且显示状态则返回非nil."
    (let ((buf (find-buffer-visiting file)))
      (if buf
	  (let ((display-count (buffer-local-value 'buffer-display-count buf)))
	    (if (> display-count 0) display-count nil))
	)
      )
    )
  (let ((r-list recentf-list))
    (defsubst keep-default-old-and-visible-recentf-p (file)
      "判断文件FILE是否应该显示,应该显示则返回非nil."
      (if (recentf-keep-default-predicate file)
	  (or (member file r-list)
	      (file-was-visible-p file))
	)
      )
    )
  (setq recentf-keep '(keep-default-old-and-visible-recentf-p))

  (recentf-mode t)
  (global-set-key (kbd "C-x C-r") 'recentf-open-files)

  (with-eval-after-load 'evil
    (evil-set-initial-state 'recentf-dialog-mode 'emacs)
    )
  )

(provide 'init-recentf)
;;;  init-recentf.el ends here
