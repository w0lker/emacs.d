;;; package -- 搜索设置
;;; Commentary:
;;; Code:

;; 显示匹配数目以及目前光标所在的匹配位置
(config-after-fetch-require 'anzu
  (setq case-fold-search t) ;; 搜索时大小写不敏感,nil 表示敏感
  (custom-set-variables
   '(anzu-mode-lighter "")
   '(anzu-deactivate-region t)
   '(anzu-search-threshold 1000)
   '(anzu-replace-threshold 50)
   '(anzu-replace-to-string-separator " => "))
  (global-anzu-mode t)

  (config-after-fetch-require 'diminish
    (diminish 'anzu-mode)
    )

  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
  (define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)
  )

(config-after-fetch-require 'grep
  ;; 文档查找, 可以随时使用M-?查找当前目录和其子目录下包含特点文本的所有文件
  (setq-default grep-highlight-matches t
		grep-scroll-output t)

  ;; 使 grep buffer 支持直接修改
  (config-after-fetch-require 'wgrep)

  (config-after-fetch-require 'ag
    ;; 使用ag查找命令
    (when (executable-find "ag")
      (setq-default ag-highlight-search t)
      (global-set-key (kbd "M-?") 'ag-project))

    (config-after-fetch-require 'wgrep-ag)
    )
  )

(provide 'init-search)
;;;  init-search.el ends here
