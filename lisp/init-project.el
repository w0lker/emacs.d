;;; package -- Project 配置
;;; Commentary:
;;; Code:

(use-package projectile
  :ensure t
  :init
  ;; 配置存放目录
  (defconst projectile-cache-file (concat user-temp-dir "projectile.cache"))
  (defconst projectile-known-projects-file (concat user-temp-dir "projectile-bookmarks.eld"))
  :config
  (add-hook 'after-init-hook 'projectile-global-mode)
  (setq-default projectile-mode-line '(:eval (if (file-remote-p default-directory)
						 " " (format " [%s]" (projectile-project-name)))))
  (use-package guide-key
    :ensure t
    :config
    ;; 按 "C-c p" 会获得提示菜单
    (add-to-list 'guide-key/guide-key-sequence "C-c p")
    )
  )

(provide 'init-project)
;;;  init-project.el ends here
