;;; package -- 文件查找模式配置
;;; Commentary:
;;; Code:

;; 使用C-f切换原生自带的模式
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)

(when (maybe-require-package 'ido-ubiquitous)
  (ido-ubiquitous-mode t))

;; 使用smex设置M-x命令补全
(when (maybe-require-package 'smex)
  ;; Change path for ~/.smex-items
  (setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
  (global-set-key [remap execute-extended-command] 'smex))

;; 设置默认buffer打开到当前选中的面板
(setq ido-default-buffer-method 'selected-window)

;; 使用历史使用的操作
;; http://www.reddit.com/r/emacs/comments/21a4p9/use_recentf_and_ido_together/cgbprem
(add-hook 'ido-setup-hook (lambda () (define-key ido-completion-map [up] 'previous-history-element)))

(provide 'init-ido)
;;;  init-ido.el ends here
