;;; package -- MiniBuffer查找自动补全模式Ido配置
;;; Commentary:
;;; Code:

;; 使用C-f切换原生自带的模式
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)
(setq ido-save-directory-list-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "ido.last"))
(ido-mode t)
(ido-everywhere t)

;; 尽量让Ido在更多场景可以使用
(when (require-package 'ido-ubiquitous)
  (ido-ubiquitous-mode t))

;; 使用smex，允许Ido对M-x命令进行补全
(when (require-package 'smex)
  ;; Change path for ~/.smex-items
  (setq smex-save-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "smex-items"))
  (global-set-key [remap execute-extended-command] 'smex))

;; 设置buffer默认打开到当前选中的面板
(setq ido-default-buffer-method 'selected-window)

;; 配置简洁的yes/no确认
(require-package 'ido-yes-or-no)
(ido-yes-or-no-mode 1)

;; 通过C-j可以停止补全，防止有时候创建新文件时，由于自动补全出包含新建文件名中的已存在文件无法创建新文件的问题。
(require-package 'crm-custom)
(crm-custom-mode 1)

(provide 'init-ido)
;;;  init-ido.el ends here
