;;; Package -- Python开发环境
;;; Commentary:
;;; Code:

(use-package python
  :mode (("SConstruct\\'" . python-mode)
	 ("SConscript\\'" . python-mode)
	 ("\\.py\\'" . python-mode))
  :init
  ;; 解决 “ansi-color-filter-apply: Args out of range” 这个问题
  (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-completion-native-enable nil)
  (setq python-shell-prompt-regexp "In \\[[0-9]+\\]: ")
  (setq python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: ")
  :config
  (defun python/config-python-environment-variables ()
    "配置 python 环境变量，添加环境变量 PYENV_ROOT 和 PATH."
    (make-local-variable 'process-environment)
    (with-temp-buffer
      (call-process "bash" nil t nil "-c" "source ~/.bash_profile; env|egrep 'PYENV_ROOT|PATH'")
      (goto-char (point-min))
      (while (not (eobp))
	(setq process-environment (cons (buffer-substring (point) (line-end-position)) process-environment))
	(forward-line 1))))
  (add-hook 'python-mode-hook 'python/config-python-environment-variables)
  (use-package pyenv-mode-auto
    :ensure t
    :demand t
    :init
    (use-package pyenv-mode :ensure t)
    )
  (use-package pip-requirements :ensure t)
  (use-package company
    :ensure t
    :config
    (use-package anaconda-mode
      :ensure t
      :demand t
      :init
      (defconst anaconda-mode-installation-directory (concat user-temp-dir "anaconda-mode"))
      :config
      (add-hook 'python-mode-hook 'anaconda-mode)
      (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
      (use-package company-anaconda
	:ensure t
	:demand t
	:config
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
