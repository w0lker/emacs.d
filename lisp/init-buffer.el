;;; package -- Buffer 管理
;;; Commentary:
;;; Code:

(use-package ibuffer
  :ensure t
  :bind ("C-x C-b" . ibuffer)
  :init
  (setq-default ibuffer-show-empty-filter-groups nil)
  (setq-default ibuffer-filter-group-name-face 'font-lock-doc-face)
  ;; 同名 buffer 处理
  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator " • ")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*")
  :config
  ;; 配置文件大小显示
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))

  (use-package ibuffer-vc
    :ensure t
    :config
    (add-hook 'ibuffer-hook 'ibuffer-vc-set-filter-groups-by-vc-root)
    ;; 设置 buffer 排序
    (add-hook 'ibuffer-hook '(lambda () (unless (eq ibuffer-sorting-mode 'filename/process)
					  (ibuffer-do-sort-by-filename/process))))
    )

  (use-package evil
    :ensure t
    :config
    (if (functionp 'evil-set-initial-state)
	(evil-set-initial-state 'ibuffer-mode 'normal))
    )

  (use-package fullframe
    :config
    (fullframe ibuffer ibuffer-quit)
    )

  )

(use-package ido
  :ensure t
  :init
  ;; 历史保存目录
  (defconst ido-save-directory-list-file (concat user-temp-dir "ido.last"))
  (setq ido-enable-flex-matching t) ;; 非常开放的匹配方式 aa 可以匹配 alpha
  (setq ido-enable-regexp t) ;; 支持正则表达式
  (setq ido-use-filename-at-point nil)
  (setq ido-auto-merge-work-directories-length -1)
  (setq ido-use-virtual-buffers t)
  (setq ido-default-buffer-method 'selected-window) ;; 允许一个 buffer 同时在不同的的 frame 中打开
  :config
  (ido-mode t)
  (ido-everywhere t)

  ;; 配置简洁的 yes/no 确认
  (use-package ido-yes-or-no
    :ensure t
    :config
    (ido-yes-or-no-mode t))

  ;; 尽量让 ido 在更多场景可以使用
  (use-package ido-ubiquitous
    :ensure t
    :config
    (ido-ubiquitous-mode t))

  ;; 支持 completing-read-multiple 的补全
  (use-package crm-custom
    :ensure t
    :config
    (crm-custom-mode 1))

  ;; 支持 M-x 命令自动补全
  (use-package smex
    :ensure t
    :bind (([remap execute-extended-command] . smex))
    :init
    ;; 改变保存文件到 temp/smex-items
    (defconst smex-save-file (concat user-temp-dir "smex-items")))
  )

(provide 'init-buffer)
;;;  init-buffer.el ends here
