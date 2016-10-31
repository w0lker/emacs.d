;;; package -- Buffer管理系统ibuffer配置
;;; Commentary:
;;; Code:

;; 基本配置
(setq-default ibuffer-show-empty-filter-groups nil
              ibuffer-filter-group-name-face 'font-lock-doc-face)

;; 设置全屏显示
(require-package 'fullframe)
(after-load 'ibuffer
  (fullframe ibuffer ibuffer-quit))

;; 设置按照文件名或者进程排序
(add-hook 'ibuffer-hook '(lambda ()
                           (unless (eq ibuffer-sorting-mode 'filename/process)
                             (ibuffer-do-sort-by-filename/process))))
;; 配置比较友好的显示buffer尺寸
(after-load 'ibuffer
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size))))))

;; 对同名的buffer进行处理
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; vim快捷键
(after-load 'ibuffer
  (if (functionp 'evil-set-initial-state)
      (evil-set-initial-state 'ibuffer-mode 'normal)))

;; 设置启动快捷键
(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'init-ibuffer)

;;;  init-ibuffer.el ends here
