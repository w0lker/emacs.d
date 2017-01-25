;;; package -- 搜索设置
;;; Commentary:
;;; Code:

(fetch-package 'anzu)
(fetch-package 'grep)
(fetch-package 'ag)
(fetch-package 'wgrep-ag)

;; 显示匹配数目以及目前光标所在的匹配位置
(require 'anzu)
(setq case-fold-search t) ;; 搜索时大小写不敏感,nil 表示敏感
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => "))
(global-anzu-mode t)
(diminish 'anzu-mode)

(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

(require 'grep)
;; 文档查找, 可以随时使用M-?查找当前目录和其子目录下包含特点文本的所有文件
(setq-default grep-highlight-matches t)
(setq-default grep-scroll-output t)

(require 'ag)
(require 'wgrep-ag)
;; 使用ag查找命令
(when (executable-find "ag")
  (setq-default ag-highlight-search t)
  (global-set-key (kbd "M-?") 'ag-project))

(provide 'init-search)
;;;  init-search.el ends here
