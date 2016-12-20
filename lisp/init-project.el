;;; package -- Project 配置
;;; Commentary:
;;; Code:

;; 配置存放目录
(setq-default projectile-cache-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "projectile.cache"))
(setq-default projectile-known-projects-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "projectile-bookmarks.eld"))

(require-package 'projectile)
(add-hook 'after-init-hook 'projectile-global-mode)

(with-eval-after-load 'projectile
  (setq-default projectile-mode-line '(:eval (if (file-remote-p default-directory)
						 " " (format " [%s]" (projectile-project-name))))))

;; 按 "C-c p" 会获得提示菜单
(with-eval-after-load 'guide-key (add-to-list 'guide-key/guide-key-sequence "C-c p"))

(provide 'init-project)
;;;  init-project.el ends here
