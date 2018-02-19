;;; Package -- Python开发环境
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(config-after-require 'python
  ;; 解决 “ansi-color-filter-apply: Args out of range” 这个问题
  (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-completion-native-enable nil)
  (setq python-shell-prompt-regexp "In \\[[0-9]+\\]: ")

  (config-add-hook 'python-mode-hook
    (config-after-fetch-require 'pyenv-mode)
    (config-after-fetch-require 'pyenv-mode-auto)

    (config-after-fetch-require 'anaconda-mode
      (setq-default anaconda-mode-installation-directory (concat user-temp-dir "anaconda-mode"))
      (anaconda-mode)
      (anaconda-eldoc-mode)
      (with-eval-after-load 'company
        (config-after-fetch-require 'company-anaconda
          ;; 添加 anaconda-mode 的 company 后端
          (company/add-buffer-local-backend 'company-anaconda)
          )
        )
      )

    (yasnippet/add-buffer-local-company-backend)
    )
  )

(provide 'init-python)
;;;  init-python.el ends here
