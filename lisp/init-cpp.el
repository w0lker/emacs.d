;;; package -- C++ 配置
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\(/\\|\\`\\)[Mm]akefile" . makefile-gmake-mode))

(config-after-fetch-require 'make-mode)
(config-after-fetch-require 'cmake-mode)

(config-add-hook 'c++-mode-hook
  (with-eval-after-load 'company
    (config-after-fetch-require 'company-c-headers
      ;; 添加头文件补全到 company.
      (company/push-local-backend 'company-c-headers)
      )
    )

  (with-eval-after-load 'yasnippet
    ;; 添加 yasnippet 补全到 company.
    (company/push-local-backend 'company-yasnippet)
    )

  ;; 不要使用 package 安装，因为安装的版本和服务可能会有版本协议不一致的问题
  ;; brew install rtags --HEAD
  ;; brew service start rtags
  (config-after-require 'rtags
    (setq rtags-autostart-diagnostics t
	  rtags-completions-enabled t)
    (rtags-start-process-unless-running)
    (with-eval-after-load 'company
      (config-after-require 'company-rtags
	;; 添加 rtags 补全到 company.
	(company/push-local-backend 'company-rtags)
	)
      )
    (with-eval-after-load 'flycheck
      (config-after-require 'flycheck-rtags
	;; 添加 rtags 到 flycheck 中.
	(flycheck-select-checker 'rtags)
	(setq-local flycheck-highlighting-mode nil)
	(setq-local flycheck-check-syntax-automatically nil)
	)
      )
    )
  )

(provide 'init-cpp)
;;;  init-cpp.el ends here
