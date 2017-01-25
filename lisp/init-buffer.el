;;; package -- Buffer 管理
;;; Commentary:
;;; Code:

(fetch-package 'ibuffer)
(fetch-package 'ibuffer-vc)
(fetch-package 'ido)
(fetch-package 'ido-yes-or-no)
(fetch-package 'ido-ubiquitous)
(fetch-package 'crm-custom)
(fetch-package 'smex)

(require 'ibuffer)
(setq-default ibuffer-show-empty-filter-groups nil)
(setq-default ibuffer-filter-group-name-face 'font-lock-doc-face)

;; 配置文件大小显示
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

(defun buffer/sort-buffer ()
  "设置 buffer 名称排序."
  (unless (eq ibuffer-sorting-mode 'filename/process)
    (ibuffer-do-sort-by-filename/process)))
(add-hook 'ibuffer-hook 'buffer/sort-buffer)

;; 同名 buffer 处理
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(require 'ibuffer-vc)
(add-hook 'ibuffer-hook 'ibuffer-vc-set-filter-groups-by-vc-root)

(if (functionp 'evil-set-initial-state)
    (evil-set-initial-state 'ibuffer-mode 'normal))

(fullframe ibuffer ibuffer-quit)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'ido)
(ido-mode t)
(ido-everywhere t)

;; 历史保存目录
(defconst ido-save-directory-list-file (concat user-temp-dir "ido.last"))
;; 非常开放的匹配方式 aa 可以匹配 alpha
(setq ido-enable-flex-matching t)
;; 支持正则表达式
(setq ido-enable-regexp t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-use-virtual-buffers t)
;; 允许一个 buffer 同时在不同的的 frame 中打开
(setq ido-default-buffer-method 'selected-window)

;; 尽量让 ido 在更多场景可以使用
(require 'ido-ubiquitous)
(ido-ubiquitous-mode t)

(require 'ido-yes-or-no)
(ido-yes-or-no-mode t)

(require 'crm-custom)
(crm-custom-mode t)

;; 支持 M-x 命令自动补全
(require 'smex)
(defconst smex-save-file (concat user-temp-dir "smex-items"))
(global-set-key [remap execute-extended-command] 'smex)

(provide 'init-buffer)
;;;  init-buffer.el ends here
