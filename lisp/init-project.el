;;; package -- Project配置
;;; Commentary:
;;; Code:

(setq projectile-cache-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "projectile.cache"))
(setq projectile-known-projects-file (concat user-emacs-directory (file-name-as-directory my-temp-dir) "projectile-bookmarks.eld"))

(when (require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-global-mode)

  ;; 按"C-c p"会获得提示菜单
  (with-eval-after-load 'guide-key
    (add-to-list 'guide-key/guide-key-sequence "C-c p"))

  ;; 设置modeline显示格式
  (with-eval-after-load 'projectile
    (setq-default
     projectile-mode-line
     '(:eval
       (if (file-remote-p default-directory)
           " Prj"
         (format " Prj[%s]" (projectile-project-name)))))))

(provide 'init-project)
;;;  init-project.el ends here
