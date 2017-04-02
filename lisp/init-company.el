;;; package -- Company 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'company
  (add-hook 'after-init-hook 'global-company-mode)

  (setq company-idle-delay .5 ;; 弹出延迟时间，单位秒
	company-minimum-prefix-length 2 ;; 弹出前缀长度
	tab-always-indent 'complete ;; 首先尝试缩进，已经缩进的尝试补全
	company-backends '(company-capf
			   company-files
			   (company-dabbrev-code company-keywords)
			   company-dabbrev)
	)

  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-select-next)

  (custom-set-faces '(company-tooltip ((t :background "#403d3d"))) ;; 弹窗背景
		    '(company-tooltip-selection ((t :foreground "#f62d6e" :background "#525151"))) ;; 选中选项颜色
		    '(company-tooltip-common ((t :foreground "#f62d6e"))) ;; 前缀部分
		    '(company-tooltip-common-selection ((t :foreground "#f62d6e"))) ;; 前缀选中部分
		    '(company-tooltip-annotation ((t :foreground "#92e56d"))) ;; 注解部分
		    '(company-scrollbar-bg ((t :background "#403d3d")))
		    '(company-scrollbar-fg ((t :background "#f8f7f1")))
		    )

  (config-after-fetch-require 'company-quickhelp
    (if (memq window-system '(ns x))
	(progn
	  (setq company-quickhelp-delay nil)
	  (company-quickhelp-mode t)
	  (define-key company-active-map (kbd "M-h") 'company-quickhelp-manual-begin)
	  )
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

  (with-eval-after-load 'diminish
    (diminish 'company-mode)
    (diminish 'abbrev-mode)
    )

  (defun company/add-buffer-local-backend (backend &optional append)
    "添加 buffer 级别的 BACKEND 到 `company-backends' ，如果 APPEND 是 non-nil 则添加到后面，否则添加为 company-dabbrev-code 的参数."
    (let* ((company/orig-company-backends company-backends)
	   (company/company-backends (remq (assoc 'company-dabbrev-code company/orig-company-backends) company/orig-company-backends))
	   (company/dabbrev-backends (cdr (assoc 'company-dabbrev-code company/orig-company-backends)))
	   )
      (if append
	  (setq-local company-backends (push (cons 'company-dabbrev-code (delete-dups (add-to-list 'company/dabbrev-backends backend t))) company/company-backends))
	(setq-local company-backends (push (cons 'company-dabbrev-code (delete-dups (push backend company/dabbrev-backends))) company/company-backends))
	)
      )
    )

  (defun company/add-buffer-local-first-backend (backend)
    "添加 buffer 级别的 BACKEND 到 `company-backends' 最前面"
    (let ((company/orig-company-backends company-backends))
      (setq-local company-backends (add-to-list 'company/orig-company-backends backend))
      )
    )
  )

(provide 'init-company)
;;;  init-company.el ends here
