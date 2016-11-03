;;; package -- 搜索设置
;;; Commentary:
;;; Code:

;; 显示匹配数目以及目前光标所在的匹配位置
(when (require-package 'anzu)
  (global-anzu-mode t)
  (diminish 'anzu-mode)
  (custom-set-variables
   '(anzu-mode-lighter "")
   '(anzu-deactivate-region t)
   '(anzu-search-threshold 1000)
   '(anzu-replace-threshold 50)
   '(anzu-replace-to-string-separator " => "))
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))

;; 可以在一个新的buffer中单独显示通过isearch匹配到的结果，当结果多时这个快捷键很有用
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;; 在isearch使用DEL键用来删除要搜索的字符串而不是跳到上一个结果（我这个版本中不加这个配置也可以）
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

(provide 'init-search)
;;;  init-search.el ends here
