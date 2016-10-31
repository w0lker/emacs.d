;;; package -- 字体设置
;;; Commentary:
;;; Code:

;; 设置默认字体
(set-default-font "Menlo 11")

;; 调整字体大小
(require-package 'default-text-scale)
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

(defun my/maybe-adjust-visual-fill-column ()
  "Readjust visual fill column when the global font size is modified.
This is helpful for writeroom-mode, in particular."
  ;; TODO: submit as patch
  (if visual-fill-column-mode
      (add-hook 'after-setting-font-hook 'visual-fill-column--adjust-window nil t)
    (remove-hook 'after-setting-font-hook 'visual-fill-column--adjust-window t)))
(add-hook 'visual-fill-column-mode-hook 'my/maybe-adjust-visual-fill-column)

(provide 'init-font)
;;;  init-font.el ends here
