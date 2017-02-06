;;; package -- C++ 配置
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\(/\\|\\`\\)[Mm]akefile" . makefile-gmake-mode))

(config-after-fetch-require 'make-mode)
(config-after-fetch-require 'cmake-mode)

(with-eval-after-load 'company
  (config-after-fetch-require 'company-c-headers
    (defun cpp/add-c-headers-to-company ()
      "添加头文件补全到 company."
      (completion/push-local-company-backend 'company-c-headers))
    (add-hook 'c++-mode-hook 'cpp/add-c-headers-to-company)
    )

  (with-eval-after-load 'yasnippet
    (defun cpp/add-yasnippet-to-company ()
      "添加 yasnippet 补全到 company."
      (completion/push-local-company-backend 'company-yasnippet))
    (add-hook 'c++-mode-hook 'cpp/add-yasnippet-to-company)
    )
  )

;; 不要使用 package 安装，因为安装的版本和服务可能会有版本协议不一致的问题
;; brew install rtags --HEAD
;; brew service start rtags
(config-after-require 'rtags
  (setq rtags-autostart-diagnostics t)
  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

  (with-eval-after-load 'company
    (config-after-require 'company-rtags
      (defun cpp/add-rtags-to-company ()
	"添加 rtags 补全到 company."
	(setq rtags-completions-enabled t)
	(completion/push-local-company-backend 'company-rtags)
	)
      (add-hook 'c++-mode-hook 'cpp/add-rtags-to-company)
      )
    )

  (with-eval-after-load 'flycheck
    (config-after-require 'flycheck-rtags
      (defun cpp/add-rtags-to-flycheck ()
	"添加 rtags 到 flycheck 中."
	(flycheck-select-checker 'rtags)
	(setq-local flycheck-highlighting-mode nil)
	(setq-local flycheck-check-syntax-automatically nil)
	)
      (add-hook 'c++-mode-hook 'cpp/add-rtags-to-flycheck)
      )
    )
  )

(provide 'init-cpp)
;;;  init-cpp.el ends here
