;;; package -- 搜索设置
;;; Commentary:
;;; Code:

(use-package isearch
  :bind (:map isearch-mode-map
	      ("C-o" . isearch-occur)
	      ([remap isearch-delete-char] . isearch-del-char)
	      )
  :init
  ;; 搜索时大小写不敏感,nil 表示敏感
  (setq case-fold-search t)
  :config
  ;; 显示匹配数目以及目前光标所在的匹配位置
  (use-package anzu
    :ensure t
    :diminish anzu-mode
    :bind (([remap query-replace-regexp] . anzu-query-replace-regexp)
	   ([remap query-replace] . anzu-query-replace))
    :init
    (custom-set-variables
     '(anzu-mode-lighter "")
     '(anzu-deactivate-region t)
     '(anzu-search-threshold 1000)
     '(anzu-replace-threshold 50)
     '(anzu-replace-to-string-separator " => "))
    :config
    (global-anzu-mode t)
    )
  )

(use-package grep
  :init
  ;; 文档查找, 可以随时使用M-?查找当前目录和其子目录下包含特点文本的所有文件
  (setq-default grep-highlight-matches t)
  (setq-default grep-scroll-output t)
  :config
  (use-package ag
    :ensure t
    :config
    (use-package wgrep-ag :ensure t)
    ;; 使用ag查找命令
    (when (executable-find "ag")
      (setq-default ag-highlight-search t)
      (global-set-key (kbd "M-?") 'ag-project))
    )
  )

(provide 'init-search)
;;;  init-search.el ends here
