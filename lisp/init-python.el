;;; Package -- Python开发环境
;;; Commentary:
;;; Code:

(config-after-require 'python
  (add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

  ;; 解决 “ansi-color-filter-apply: Args out of range” 这个问题
  (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-completion-native-enable nil)
  (setq python-shell-prompt-regexp "In \\[[0-9]+\\]: ")

  (config-after-fetch-require 'pyenv-mode)
  (config-after-fetch-require 'pyenv-mode-auto)

  (config-after-fetch-require 'anaconda-mode
    (setq-default anaconda-mode-installation-directory (concat user-temp-dir "anaconda-mode"))
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

    (with-eval-after-load 'company
      (config-after-fetch-require 'company-anaconda
	(defun python/add-anaconda-to-company()
	  "添加 anaconda-mode 的 company 后端"
	  (completion/push-local-company-backend 'company-anaconda))
	(add-hook 'python-mode-hook 'python/add-anaconda-to-company)
	)
      )
    )
  )

(provide 'init-python)
;;;  init-python.el ends here
