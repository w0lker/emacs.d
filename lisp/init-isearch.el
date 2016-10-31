;;; package -- isearch设置
;;; Commentary:
;;; Code:

;; 显示匹配数目以及目前光标所在的匹配位置
(when (maybe-require-package 'anzu)
  (global-anzu-mode t)
  (diminish 'anzu-mode)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))

;; 可以在一个新的buffer中单独显示通过isearch匹配到的结果，当结果多时这个快捷键很有用
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;; 在isearch使用DEL键用来删除要搜索的字符串而不是跳到上一个结果（我这个版本中不加这个配置也可以）
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

;; 局部搜索,在搜索模式下使用快捷键C-M-w后会使用光标下的内容进行搜索
;; See http://www.emacswiki.org/emacs/SearchAtPoint
(defun isearch-yank-symbol ()
  "*Put symbol at current point into search string."
  (interactive)
  (let ((sym (symbol-at-point)))
    (if sym
        (progn
          (setq isearch-regexp t
                isearch-string (concat "\\_<" (regexp-quote (symbol-name sym)) "\\_>")
                isearch-message (mapconcat 'isearch-text-char-description isearch-string "")
                isearch-yank-flag t))
      (ding)))
  (isearch-search-and-update))

(define-key isearch-mode-map "\C-\M-w" 'isearch-yank-symbol)

;; 皮肤
(defun my/isearch/isearch-face-settings ()
  "Face settings for `isearch'."
  (set-face-foreground 'isearch "brightred")
  ;;(set-face-background 'isearch "blue")
  (custom-set-faces '(isearch-fail ((((class color)) (:background "red"))))))
(eval-after-load "isearch"
  (lambda () (my/isearch/isearch-face-settings)))

(provide 'init-isearch)
;;;  init-isearch.el ends here
