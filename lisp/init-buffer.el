;;; package -- Buffer管理配置
;;; Commentary:
;;; Code:


;; 设置全屏显示
(with-eval-after-load 'ibuffer
  (fullframe ibuffer ibuffer-quit))

(require-package 'ibuffer-vc)

;; 设置按照文件名或者进程排序
(add-hook 'ibuffer-hook '(lambda ()
			   (ibuffer-vc-set-filter-groups-by-vc-root)
                           (unless (eq ibuffer-sorting-mode 'filename/process)
                             (ibuffer-do-sort-by-filename/process))))

;; 配置比较友好的显示buffer尺寸
(with-eval-after-load 'ibuffer
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

;; ibuffer配置
(setq-default ibuffer-show-empty-filter-groups nil
              ibuffer-filter-group-name-face 'font-lock-doc-face)

;; Vim快捷键
(with-eval-after-load 'ibuffer
  (if (functionp 'evil-set-initial-state)
      (evil-set-initial-state 'ibuffer-mode 'normal)))

;; 设置启动快捷键
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; Buffer快捷切换
(require-package 'swbuff)
(setq swbuff-exclude-buffer-regexps '("^ " "^\*Rtags.*\*" "^\*Ibuffer.*\*")
      swbuff-recent-buffers-first t
      swbuff-clear-delay-ends-switching 1)
(custom-set-faces '(swbuff-current-buffer-face
                    ((t :foreground "#ffffff" :background "#6aa84f"))))
(global-set-key (kbd "C-<tab>") 'swbuff-switch-to-next-buffer)


;; Minibuffer 设置
;; 使用C-f切换原生自带的模式
;; 通过C-j可以停止补全，防止有时候创建新文件时，由于自动补全出包含新建文件名中的已存在文件无法创建新文件的问题。
(ido-mode t)
(ido-everywhere t)

(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)
(setq ido-save-directory-list-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "ido.last"))

;; 尽量让Ido在更多场景可以使用
(when (require-package 'ido-ubiquitous)
  (ido-ubiquitous-mode t))

;; 使用smex，允许Ido对M-x命令进行补全
(when (require-package 'smex)
  ;; Change path for ~/.smex-items
  (setq smex-save-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "smex-items"))
  (global-set-key [remap execute-extended-command] 'smex))

;; 允许一个buffer同时在不同的的frame中打开
(setq ido-default-buffer-method 'selected-window)

;; 支持补全recentf文件中历史
(add-hook 'ido-setup-hook (lambda () (define-key ido-completion-map [up] 'previous-history-element)))

;; 配置简洁的yes/no确认
(require-package 'ido-yes-or-no)
(ido-yes-or-no-mode 1)


(provide 'init-buffer)
;;;  init-buffer.el ends here
