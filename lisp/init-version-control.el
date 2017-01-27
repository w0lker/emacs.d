;;; package -- 版本控制
;;; Commentary:
;;; Code:

(fetch-package 'diff-hl)
(fetch-package 'magit)
(fetch-package 'git-commit)
(fetch-package 'gitignore-mode)
(fetch-package 'gitconfig-mode)

;; 有版本控制系统，不启动文件备份
(setq-default make-backup-files nil)
;; Ediff配置
(setq-default ediff-split-window-function 'split-window-horzontally)
(setq-default ediff-window-setup-function 'ediff-setup-windows-plain)

;; 左侧显示提示修改内容
(require 'diff-hl)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

(require 'magit)
(setq-default magit-diff-refine-hunk t)
(add-hook 'git-commit-mode-hook 'goto-address-mode)
(fullframe magit-status magit-mode-quit-window)

(provide 'init-version-control)
;;;  init-version-control.el ends here
