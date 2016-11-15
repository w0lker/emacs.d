;;; package -- 版本控制
;;; Commentary:
;;; Code:

;; 有版本控制系统，不启动文件备份
(setq make-backup-files nil)

;; Ediff配置，Emacs下的diff工具
(setq ediff-split-window-function 'split-window-horzontally
      ediff-window-setup-function 'ediff-setup-windows-plain)

;; 修改内容左侧显示提示
(require-package 'diff-hl)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

;; ibuffer添加版本控制信息
(require-package 'ibuffer-vc)
(add-hook 'ibuffer-hook 'ibuffer-vc-set-filter-groups-by-vc-root)

;; git配置
(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)

(when (require-package 'magit)
  (setq-default magit-diff-refine-hunk t))

(require-package 'fullframe)
(with-eval-after-load 'magit
  (fullframe magit-status magit-mode-quit-window))

(when (require-package 'git-commit)
  (add-hook 'git-commit-mode-hook 'goto-address-mode))

(provide 'init-version-control)
;;;  init-version-control.el ends here
