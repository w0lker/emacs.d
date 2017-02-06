;;; package -- Magit 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'magit
  (setq-default make-backup-files nil ;; 有版本控制系统，不启动文件备份
		magit-diff-refine-hunk t)

  (config-after-fetch-require 'git-commit
    (add-hook 'git-commit-mode-hook 'goto-address-mode))

  (config-after-fetch-require 'fullframe
    (fullframe magit-status magit-mode-quit-window))

  (with-eval-after-load 'ido
    (setq-default magit-completing-read-function 'magit-ido-completing-read))

  (config-after-fetch-require 'gitignore-mode)

  (config-after-fetch-require 'gitconfig-mode)
  )

(provide 'init-magit)
;;;  init-magit.el ends here
