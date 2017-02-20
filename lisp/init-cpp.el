;;; package -- C++开发环境配置
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\(/\\|\\`\\)[Mm]akefile" . makefile-gmake-mode))

(config-after-fetch-require 'make-mode)
(config-after-fetch-require 'cmake-mode)

(defun cpp/current-modules-string()
  "获得当前buffer对应的项目的模块名组成的以下划线分割的字符串."
  (if (and (fboundp 'projectile-project-p) (projectile-project-p))
      (let ((current-path (buffer-file-name))
	    (project-path (projectile-project-root)))
	(if (eq (string-match project-path current-path) 0)
	    (let* ((start (string-width project-path))
		   (project-sub-path (substring current-path start -1))
		   (paths-chain (split-string (file-name-directory project-sub-path) "/" t))
		   (project-modules (if (string= (car paths-chain) "src") (cdr paths-chain) paths-chain))
		   (modules-string (string-join project-modules "_"))
		   )
	      (if modules-string (concat "_" modules-string) "")
	      )
	  )
	)
    )
  )

(config-add-hook 'c++-mode-hook
  ;; 不要使用package安装，因为安装的版本和服务可能会有版本协议不一致的问题
  ;; brew install rtags --HEAD
  ;; brew service start rtags
  (config-after-require 'rtags
    (setq rtags-autostart-diagnostics t
	  rtags-completions-enabled t)
    (rtags-start-process-unless-running)

    (with-eval-after-load 'company
      (config-after-require 'company-rtags
	;; 添加rtags补全到company.
	(company/push-local-backend 'company-rtags)
	)
      )

    (with-eval-after-load 'flycheck
      (config-after-require 'flycheck-rtags
	;; 添加rtags到flycheck中.
	(flycheck-select-checker 'rtags)
	(setq-local flycheck-highlighting-mode nil)
	(setq-local flycheck-check-syntax-automatically nil)
	)
      )
    )

  (with-eval-after-load 'company
    (with-eval-after-load 'yasnippet
      ;; 添加yasnippet补全到company.
      (company/push-local-backend 'company-yasnippet)
      )
    )
  )

(provide 'init-cpp)
;;;  init-cpp.el ends here
