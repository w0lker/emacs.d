;;; package -- Project配置
;;; Commentary:
;;; Code:

(setq-default projectile-cache-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "projectile.cache"))
(setq-default projectile-known-projects-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "projectile-bookmarks.eld"))

(require-package 'projectile)
(add-hook 'after-init-hook 'projectile-global-mode)

;; 设置 modeline 显示格式
(with-eval-after-load 'projectile
  (setq-default projectile-mode-line (if (file-remote-p default-directory) " " (format "[%s]" (projectile-project-name)))))

;; 按 "C-c p" 会获得提示菜单
(with-eval-after-load 'guide-key (add-to-list 'guide-key/guide-key-sequence "C-c p"))

(provide 'init-project)
;;;  init-project.el ends here
