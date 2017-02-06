;;; package -- Projectile 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'projectile
  (add-hook 'after-init-hook 'projectile-global-mode)
  (defconst projectile-cache-file (concat user-temp-dir "projectile.cache"))
  (defconst projectile-known-projects-file (concat user-temp-dir "projectile-bookmarks.eld"))
  (setq-default projectile-mode-line '(:eval (if (file-remote-p default-directory)
						 " " (format " [%s]" (projectile-project-name)))))
  (with-eval-after-load 'guid-key
    (config-add-hook 'projectile-mode-hook
      ;; 按 "C-c p" 会获得提示菜单
      (guide-key/add-local-guide-key-sequence "C-c p")
      )
    )
  )

(provide 'init-projectile)
;;;  init-projectile.el ends here
