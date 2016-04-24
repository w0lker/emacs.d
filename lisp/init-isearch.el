;; 显示匹配数目以及目前光标所在的匹配位置
(when (maybe-require-package 'anzu)
  (global-anzu-mode t)
  (diminish 'anzu-mode)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace))

;; 可以在一个新的buffer中单独显示通过isearch匹配到的结果，当结果多时这个快捷键很有用
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;; 在isearch使用DEL键用来删除要搜索的字符串而不失跳到上一个结果（我这个版本中不加这个配置也可以）
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


;; 使用C-SPEC标识开始位置，并且选择一段区域，然后使用C-s或者C-r搜索一段文本，然后使用M-z删除到这段文本中最后一个匹配的相关文本,会保留最后匹配的那个文本。这里的选中不支持块选中。
;; http://www.emacswiki.org/emacs/ZapToISearch
(defun zap-to-isearch (rbeg rend)
  "Kill the region between the mark and the closest portion of
the isearch match string. The behaviour is meant to be analogous
to zap-to-char; let's call it zap-to-isearch. The deleted region
does not include the isearch word. This is meant to be bound only
in isearch mode.  The point of this function is that oftentimes
you want to delete some portion of text, one end of which happens
to be an active isearch word. The observation to make is that if
you use isearch a lot to move the cursor around (as you should,
it is much more efficient than using the arrows), it happens a
lot that you could just delete the active region between the mark
and the point, not include the isearch word."
  (interactive "r")
  (when (not mark-active)
    (error "Mark is not active"))
  (let* ((isearch-bounds (list isearch-other-end (point)))
         (ismin (apply 'min isearch-bounds))
         (ismax (apply 'max isearch-bounds))
         )
    (if (< (mark) ismin)
        (kill-region (mark) ismin)
      (if (> (mark) ismax)
          (kill-region ismax (mark))
        (error "Internal error in isearch kill function.")))
    (isearch-exit)
    ))

(define-key isearch-mode-map [(meta z)] 'zap-to-isearch)

;; 先选中一个特定的区域，然后使用C-s或者C-r搜索特定字符串，然后按C-return，这时光标会停在这段区域附近最后一个能匹配上的特定字符串后面的位置。如果后面跟一个kill的命令就能非常快的删除整个区域。
;; http://www.emacswiki.org/emacs/ZapToISearch
(defun isearch-exit-other-end (rbeg rend)
  "Exit isearch, but at the other end of the search string.
This is useful when followed by an immediate kill."
  (interactive "r")
  (isearch-exit)
  (goto-char isearch-other-end))

(define-key isearch-mode-map [(control return)] 'isearch-exit-other-end)


;; 设置搜索的显示的皮肤
(defun my/isearch-face-settings ()
  "Face settings for `isearch'."
  (set-face-foreground 'isearch "brightred")
  ;;(set-face-background 'isearch "blue")
  (custom-set-faces '(isearch-fail ((((class color)) (:background "red"))))))

(eval-after-load "isearch"
  `(my/isearch-face-settings))

(provide 'init-isearch)
