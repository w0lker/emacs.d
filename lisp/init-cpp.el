;;; package -- C++ 配置
;;; Commentary:
;;; Code:

(use-package cc-mode
  :mode ("\\.h\\'" . c++-mode)
  :config
  (use-package company-c-headers
    :ensure t
    :demand t
    :config
    (use-package company
      :ensure t
      :config
      (defun cpp/add-c-headers-to-company()
	"添加头文件补全到 company."
	(completion/push-local-company-backend 'company-c-headers))
      (add-hook 'c-mode-common-hook 'cpp/add-c-headers-to-company)
      )
    )

  (use-package rtags
    :ensure t
    :demand t
    :init
    (setq rtags-autostart-diagnostics t)
    :config
    (use-package company
      :ensure t
      :demand t
      :config
      (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
      (defun cpp/add-rtags-to-company()
	"添加 rtags 补全到 company."
	(setq rtags-completions-enabled t)
	(completion/push-local-company-backend 'company-rtags)
	)
      (add-hook 'c-mode-common-hook 'cpp/add-rtags-to-company)
      )
    
    (use-package flycheck
      :ensure t
      :demand t
      :config
      (use-package flycheck-rtags
	:config
	(defun cpp/add-rtags-to-flycheck()
	  "添加 rtags 到 flycheck 中."
	  (flycheck-select-checker 'rtags)
	  (setq-local flycheck-highlighting-mode nil)
	  (setq-local flycheck-check-syntax-automatically nil))
	(add-hook 'c-mode-common-hook 'cpp/add-rtags-to-flycheck)
	)
      )
    )

  (use-package make-mode
    :mode ("\\(/\\|\\`\\)[Mm]akefile" . makefile-gmake-mode)
    )

  (use-package cmake-mode
    :ensure t
    )
  )

(provide 'init-cpp)
;;;  init-cpp.el ends here
