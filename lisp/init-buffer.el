;;; package -- Buffer 管理
;;; Commentary:
;;; Code:

(fetch-package 'ido)
(fetch-package 'ido-yes-or-no)
(fetch-package 'ido-ubiquitous)
(fetch-package 'crm-custom)
(fetch-package 'smex)
(fetch-package 'ido-select-window)
(fetch-package 'dired+)
(fetch-package 'dired-sort)
(fetch-package 'diff-hl)
(fetch-package 'ibuffer)
(fetch-package 'ibuffer-vc)
(fetch-package 'vagrant)
(fetch-package 'vagrant-tramp)


(with-eval-after-load 'files
  ;; 如果 gnu ls 可用就使用
  (let ((gls (executable-find "gls")))
    (when gls
      (setq insert-directory-program gls)))
  )

(require 'recentf)
(with-eval-after-load 'recentf
  (setq recentf-max-saved-items 2000)
  (setq recentf-auto-cleanup 'never) ;; 使用tramp模式的时候需要关闭，否则会判断文件的可访问性
  (setq-default recentf-save-file  (concat user-temp-dir "recentf")) ;; 保存目录
  (setq-default recentf-exclude '("/tmp/" "\\.emacs\\.d/temp/"))
  (recentf-mode t)
  (global-set-key (kbd "C-x C-r") 'recentf-open-files))

(require 'ido)
(with-eval-after-load 'ido
  (ido-mode 1)
  (ido-everywhere 1)
  (defconst ido-save-directory-list-file (concat user-temp-dir "ido.last")) ;; 保存目录
  (setq ido-enable-flex-matching t) ;; 非常开放的匹配方式 aa 可以匹配 alpha
  (setq ido-enable-regexp t) ;; 支持正则表达式
  (setq ido-use-filename-at-point nil)
  (setq ido-auto-merge-work-directories-length -1)
  (setq ido-use-virtual-buffers t)
  (setq ido-default-buffer-method 'selected-window) ;; 允许一个 buffer 同时在不同的的 frame 中打开

  ;; 支持 M-x 命令自动补全
  (require 'smex)
  (defconst smex-save-file (concat user-temp-dir "smex-items"))
  (global-set-key [remap execute-extended-command] 'smex)

  ;; 尽量让 ido 支持更多场景的补全
  (require 'ido-ubiquitous)
  (ido-ubiquitous-mode 1)

  (require 'ido-yes-or-no)
  (ido-yes-or-no-mode 1)

  (require 'crm-custom)
  (crm-custom-mode 1)

  (require 'ido-select-window)
  (global-set-key (kbd "C-x o") 'ido-select-window)
  )

(with-eval-after-load 'dired
  (setq dired-recursive-deletes 'top)
  (setq dired-dwim-target t)

  (define-key dired-mode-map [mouse-2] 'dired-find-file)

  (require 'dired+)
  ;; 使用 快捷键 ( 触发详情和关闭文件详情
  (setq diredp-hide-details-initially-flag nil)
  (global-dired-hide-details-mode t)

  (require 'dired-sort)

  (require 'diff-hl)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)

  (with-eval-after-load 'guide-key
    (add-hook 'dired-mode-hook (lambda () (guide-key/add-local-guide-key-sequence "%"))))

  (with-eval-after-load 'evil
    (evil-set-initial-state 'dired-mode 'normal))
  )

(require 'ibuffer)
(with-eval-after-load 'ibuffer
  (setq-default ibuffer-show-empty-filter-groups nil)
  (setq-default ibuffer-filter-group-name-face 'font-lock-doc-face)

  (require 'uniquify) ;; 同名 buffer 处理
  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator " • ")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*")

  (defun buffer/ibuffer-friendly-size-column-show ()
    "配置 size-h 列使用比较友好的显示方式."
    (define-ibuffer-column size-h
      (:name "Size" :inline t)
      (cond
       ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
       ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
       (t (format "%8d" (buffer-size))))))
  (add-hook 'ibuffer-hook 'buffer/ibuffer-friendly-size-column-show)

  (defun buffer/ibuffer-name-sort ()
    "设置 buffer 按照文件名排序."
    (unless (eq ibuffer-sorting-mode 'filename/process)
      (ibuffer-do-sort-by-filename/process)))
  (add-hook 'ibuffer-hook 'buffer/ibuffer-name-sort)

  ;; 添加版本控制信息支持
  (require 'ibuffer-vc)
  (add-hook 'ibuffer-hook 'ibuffer-vc-set-filter-groups-by-vc-root)

  (with-eval-after-load 'evil
    (evil-set-initial-state 'ibuffer-mode 'normal))

  (with-eval-after-load 'fullframe
    (fullframe ibuffer ibuffer-quit))

  (global-set-key (kbd "C-x C-b") 'ibuffer)
  )

(with-eval-after-load 'tramp
  (defconst tramp-persistency-file-name (concat user-temp-dir "tramp"))

  ;; 指定默认使用的方法
  ;; 使用ssh会比scp快
  ;; 在使用的时候，可以临时指定其它的方法
  ;; C-x C-f /method:user@remotehost:filename
  (setq tramp-default-method "ssh")

  ;; 优化大文件的网络传输，如问题：tramp: Waiting for remote host to process data
  (setq tramp-chunksize 500)

  (defun tramp-shell (&optional buffer)
    "当使用tramp连到某个远程文件后，创建一个连接到当前远程文件的shell BUFFER."
    (interactive)
    (let* ((tramp-path (when (tramp-tramp-file-p default-directory)
			 (tramp-dissect-file-name default-directory)))
	   (host (tramp-file-name-real-host tramp-path))
	   (user (if (tramp-file-name-user tramp-path)
		     (format "%s@" (tramp-file-name-user tramp-path)) ""))
	   (new-buffer-name (format "*shell:%s%s*" user host)))
      (shell (if host new-buffer-name buffer))))

  (require 'vagrant)
  (require 'vagrant-tramp)
  )

(provide 'init-buffer)
;;;  init-buffer.el ends here
