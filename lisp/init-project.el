;;; package -- 开发项目配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'flycheck
  (setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)
  (add-hook 'after-init-hook 'global-flycheck-mode)

  (config-after-fetch-require 'diminish
    (diminish 'flycheck-mode)
    )
  )

(config-after-fetch-require 'yasnippet
  (defconst completion/yas-snippet-dirs (expand-file-name ".snippets" user-emacs-directory))
  (setq-default yas-snippet-dirs completion/yas-snippet-dirs)
  (add-to-list 'load-path completion/yas-snippet-dirs)
  (yas-global-mode t)

  (config-after-fetch-require 'diminish
    (diminish 'yas-minor-mode)
    )
  )

(config-after-require 'hippie-exp
  (setq hippie-expand-try-functions-list '(try-complete-file-name-partially
					   try-complete-file-name
					   try-expand-dabbrev
					   try-expand-dabbrev-all-buffers
					   try-expand-dabbrev-from-kill))
  (global-set-key (kbd "M-/") 'hippie-expand)
  )

(config-after-fetch-require 'company
  (add-hook 'after-init-hook 'global-company-mode)

  (setq completion-cycle-threshold 5)
  (add-to-list 'completion-styles 'initials t)

  (setq company-idle-delay .3
	company-minimum-prefix-length 2)

  (setq tab-always-indent 'complete)
  (setq-default company-backends '((company-capf company-dabbrev-code) company-dabbrev company-files))
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-select-next)

  (config-after-fetch-require 'diminish
    (diminish 'company-mode)
    )

  (custom-set-faces
   '(company-tooltip ((t :background "#403d3d"))) ;; 弹窗背景
   '(company-tooltip-selection ((t :foreground "#f62d6e" :background "#525151"))) ;; 选中选项颜色
   '(company-tooltip-common ((t :foreground "#f62d6e"))) ;; 前缀部分
   '(company-tooltip-common-selection ((t :foreground "#f62d6e"))) ;; 前缀选中部分
   '(company-tooltip-annotation ((t :foreground "#92e56d"))) ;; 注解部分
   '(company-scrollbar-bg ((t :background "#403d3d")))
   '(company-scrollbar-fg ((t :background "#f8f7f1"))))

  (with-eval-after-load 'evil
    (evil-declare-change-repeat 'company-complete))

  (defun completion/push-local-company-backend (backend)
    "添加 BACKEND 到 buffer 级别的 `company-backends'."
    (setq-local company-backends (append (list backend) company-backends)))
  
  (config-after-fetch-require 'company-quickhelp
    (if window-system
	(progn
	  (setq company-quickhelp-delay nil)
	  (company-quickhelp-mode t)
	  (define-key company-active-map (kbd "M-h") 'company-quickhelp-manual-begin)))
    )
  )

(config-after-fetch-require 'projectile
  (add-hook 'after-init-hook 'projectile-global-mode)

  (defconst projectile-cache-file (concat user-temp-dir "projectile.cache"))
  (defconst projectile-known-projects-file (concat user-temp-dir "projectile-bookmarks.eld"))
  (setq-default projectile-mode-line '(:eval (if (file-remote-p default-directory)
						 " " (format " [%s]" (projectile-project-name)))))

  (with-eval-after-load 'guid-key
    ;; 按 "C-c p" 会获得提示菜单
    (add-hook 'projectile-mode-hook (lambda () (guide-key/add-local-guide-key-sequence "C-c p")))
    )
  )

(config-after-fetch-require 'magit
  (setq-default make-backup-files nil) ;; 有版本控制系统，不启动文件备份
  (setq-default magit-diff-refine-hunk t)

  (config-after-fetch-require 'git-commit
    (add-hook 'git-commit-mode-hook 'goto-address-mode))

  (config-after-fetch-require 'fullframe
    (fullframe magit-status magit-mode-quit-window))

  (with-eval-after-load 'ido
    (setq-default magit-completing-read-function 'magit-ido-completing-read))
  )

(config-after-fetch-require 'gitignore-mode)

(config-after-fetch-require 'gitconfig-mode)

(config-after-fetch-require 'diminish
  (diminish 'abbrev-mode))

(provide 'init-project)
;;;  init-project.el ends here
