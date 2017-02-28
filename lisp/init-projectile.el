;;; package -- Projectile 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'projectile
  (config-add-hook 'after-init-hook
    (projectile-global-mode)
    )
  (setq projectile-cache-file (concat user-temp-dir "projectile.cache")
		projectile-known-projects-file (concat user-temp-dir "projectile-bookmarks.eld")
		projectile-mode-line '(:eval (if (file-remote-p default-directory) " " (unless (string= "-" (projectile-project-name))(format " [%s]" (projectile-project-name)))))
		)

  (with-eval-after-load 'guid-key
    ;; 按 "C-c p" 会获得提示菜单
    (add-to-list 'guide-key/guide-key-sequence "C-c p")
    )
  )

(provide 'init-projectile)
;;;  init-projectile.el ends here
