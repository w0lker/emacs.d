;;; package -- Buffer 管理配置
;;; Commentary:
;;; Code:

(require-package 'ibuffer)
;; 设置全屏显示
(with-eval-after-load 'ibuffer (fullframe ibuffer ibuffer-quit))

(setq-default ibuffer-show-empty-filter-groups nil)
(setq-default ibuffer-filter-group-name-face 'font-lock-doc-face)

;; 配置文件大小显示
(with-eval-after-load 'ibuffer
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size))))))

;; 同名 buffer 处理
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; 设置启动快捷键
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; 配置版本控制支持
(require-package 'ibuffer-vc)
(add-hook 'ibuffer-hook 'ibuffer-vc-set-filter-groups-by-vc-root)

;; 设置 buffer 排序
(add-hook 'ibuffer-hook '(lambda () (unless (eq ibuffer-sorting-mode 'filename/process)
				      (ibuffer-do-sort-by-filename/process))))

;; 配置 Vim 快捷键
(with-eval-after-load 'ibuffer
  (if (functionp 'evil-set-initial-state)
      (evil-set-initial-state 'ibuffer-mode 'normal)))

;; 使用 C-TAB 进行 Buffer 切换
(require-package 'swbuff)
(setq swbuff-recent-buffers-first t)
(setq swbuff-clear-delay-ends-switching 0.8)
(setq swbuff-exclude-buffer-regexps '("^ " "^\*Rtags.*\*" "^\*Ibuffer.*\*"))
;; 配置皮肤
(custom-set-faces '(swbuff-current-buffer-face ((t :foreground "#ffffff" :background "#6aa84f"))))
(global-set-key (kbd "C-<tab>") 'swbuff-switch-to-next-buffer)

(require 'ido)
;; 历史保存目录
(setq-default ido-save-directory-list-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "ido.last"))
(setq ido-enable-flex-matching t) ;; 非常开放的匹配方式 aa 可以匹配 alpha
(setq ido-enable-regexp t) ;; 支持正则表达式
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-use-virtual-buffers t)
(setq ido-default-buffer-method 'selected-window) ;; 允许一个 buffer 同时在不同的的 frame 中打开
(ido-mode t)
(ido-everywhere t)

;; 配置简洁的yes/no确认
(require-package 'ido-yes-or-no)
(ido-yes-or-no-mode 1)

;; 尽量让 Ido 在更多场景可以使用
(require-package 'ido-ubiquitous)
(ido-ubiquitous-mode t)

;; 支持 completing-read-multiple 的补全
(require-package 'crm-custom)
(require 'crm-custom)
(crm-custom-mode 1)

;; 支持命令自动补全
(require-package 'smex)
;; 改变保存文件到 temp/smex-items
(setq-default smex-save-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "smex-items"))
(global-set-key [remap execute-extended-command] 'smex)

(provide 'init-buffer)
;;;  init-buffer.el ends here
