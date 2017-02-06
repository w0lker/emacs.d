;;; package -- Ibuffer 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'ibuffer
  (setq-default ibuffer-show-empty-filter-groups nil)
  (setq-default ibuffer-filter-group-name-face 'font-lock-doc-face)

  ;; 同名 buffer 处理
  (config-after-require 'uniquify
    (setq uniquify-buffer-name-style 'reverse)
    (setq uniquify-separator " • ")
    (setq uniquify-after-kill-buffer-p t)
    (setq uniquify-ignore-buffers-re "^\\*"))

  (config-add-hook 'ibuffer-hook
    ;; 配置 size-h 列使用比较友好的显示方式
    (define-ibuffer-column size-h
      (:name "Size" :inline t)
      (cond
       ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
       ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
       (t (format "%8d" (buffer-size))))
      )
    ;; 设置 buffer 按照文件名排序
    (unless (eq ibuffer-sorting-mode 'filename/process)
      (ibuffer-do-sort-by-filename/process)
      )
    )

  (config-after-fetch-require 'ibuffer-vc
    (add-hook 'ibuffer-hook 'ibuffer-vc-set-filter-groups-by-vc-root)
    )

  (config-after-fetch-require 'fullframe
    (fullframe ibuffer ibuffer-quit))

  (with-eval-after-load 'evil
    (evil-set-initial-state 'ibuffer-mode 'normal))

  (global-set-key (kbd "C-x C-b") 'ibuffer)
  )

(provide 'init-ibuffer)
;;;  init-ibuffer.el ends here
