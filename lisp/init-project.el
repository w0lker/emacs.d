;;; package -- Project 配置
;;; Commentary:
;;; Code:

(fetch-package 'projectile)

(require 'projectile)
(add-hook 'after-init-hook 'projectile-global-mode)

(with-eval-after-load 'projectile
  (defconst projectile-cache-file (concat user-temp-dir "projectile.cache"))
  (defconst projectile-known-projects-file (concat user-temp-dir "projectile-bookmarks.eld"))
  (setq-default projectile-mode-line '(:eval (if (file-remote-p default-directory)
						 " " (format " [%s]" (projectile-project-name)))))
  )

;; 按 "C-c p" 会获得提示菜单
(with-eval-after-load 'guid-key
  (add-to-list 'guide-key/guide-key-sequence "C-c p"))

(provide 'init-project)
;;;  init-project.el ends here
