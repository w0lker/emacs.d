;;; package -- Company 配置
;;; Commentary:
;;; Code:

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
  
  (config-after-require 'hippie-exp
    (setq hippie-expand-try-functions-list '(try-complete-file-name-partially
					     try-complete-file-name
					     try-expand-dabbrev
					     try-expand-dabbrev-all-buffers
					     try-expand-dabbrev-from-kill))
    (global-set-key (kbd "M-/") 'hippie-expand)
    )

  (config-after-fetch-require 'diminish
    (diminish 'abbrev-mode))
  )

(provide 'init-company)
;;;  init-company.el ends here
