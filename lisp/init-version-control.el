;;; package -- 版本控制
;;; Commentary:
;;; Code:

;; 有版本控制系统，不启动文件备份
(setq-default make-backup-files nil)

;; Ediff配置
(setq-default ediff-split-window-function 'split-window-horzontally)
(setq-default ediff-window-setup-function 'ediff-setup-windows-plain)

;; 修改内容左侧显示提示
(require-package 'diff-hl)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

;; Git 配置
(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)

(require-package 'magit)
(setq-default magit-diff-refine-hunk t)

(require-package 'fullframe)
(with-eval-after-load 'magit (fullframe magit-status magit-mode-quit-window))

(require-package 'git-commit)
(add-hook 'git-commit-mode-hook 'goto-address-mode)

(provide 'init-version-control)
;;;  init-version-control.el ends here
