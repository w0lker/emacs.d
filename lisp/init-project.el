;;; package -- Project 配置
;;; Commentary:
;;; Code:

(fetch-package 'projectile)
(fetch-package 'magit)
(fetch-package 'git-commit)
(fetch-package 'gitignore-mode)
(fetch-package 'gitconfig-mode)


(require 'projectile)
(add-hook 'after-init-hook 'projectile-global-mode)

(defconst projectile-cache-file (concat user-temp-dir "projectile.cache"))
(defconst projectile-known-projects-file (concat user-temp-dir "projectile-bookmarks.eld"))
(setq-default projectile-mode-line '(:eval (if (file-remote-p default-directory)
					       " " (format " [%s]" (projectile-project-name)))))

;; 按 "C-c p" 会获得提示菜单
(with-eval-after-load 'guid-key
  (add-to-list 'guide-key/guide-key-sequence "C-c p"))

(require 'magit)
(setq-default make-backup-files nil) ;; 有版本控制系统，不启动文件备份
(setq-default magit-diff-refine-hunk t)

(require 'git-commit)
(add-hook 'git-commit-mode-hook 'goto-address-mode)

(with-eval-after-load 'ido
  (setq-default magit-completing-read-function 'magit-ido-completing-read))

(with-eval-after-load 'fullframe
  (fullframe magit-status magit-mode-quit-window))

(require 'gitignore-mode)

(require 'gitconfig-mode)

(provide 'init-project)
;;;  init-project.el ends here
