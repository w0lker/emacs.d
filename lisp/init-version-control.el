;;; package -- 版本控制
;;; Commentary:
;;; Code:

;; 有版本控制系统，不启动文件备份
(setq-default make-backup-files nil)
;; Ediff配置
(setq-default ediff-split-window-function 'split-window-horzontally)
(setq-default ediff-window-setup-function 'ediff-setup-windows-plain)

;; 修改内容左侧显示提示
(use-package diff-hl
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
  )

(use-package gitignore-mode :ensure t)
(use-package gitconfig-mode :ensure t)

(use-package magit
  :ensure t
  :init
  (setq-default magit-diff-refine-hunk t)
  :config
  (use-package fullframe
    :config
    (fullframe magit-status magit-mode-quit-window)
    )
  (use-package git-commit
    :ensure t
    :commands goto-address-mode
    :config
    (add-hook 'git-commit-mode-hook 'goto-address-mode)
    )
  )

(provide 'init-version-control)
;;;  init-version-control.el ends here
