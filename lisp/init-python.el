;;; Package -- Python开发环境
;;; Commentary:
;;; Code:


(add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(fetch-package 'python)
(require 'python)

;; 解决 “ansi-color-filter-apply: Args out of range” 这个问题
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
(setq python-shell-interpreter "ipython")
(setq python-shell-completion-native-enable nil)
(setq python-shell-prompt-regexp "In \\[[0-9]+\\]: ")

(fetch-package 'exec-path-from-shell)
(require 'exec-path-from-shell)
(with-eval-after-load 'exec-path-from-shell
  (dolist (var '("PYENV_ROOT"))
    (add-to-list 'exec-path-from-shell-variables var))
  )

(fetch-package 'pyenv-mode)
(require 'pyenv-mode)
(fetch-package 'pyenv-mode-auto)
(require 'pyenv-mode-auto)

(fetch-package 'anaconda-mode)
(require 'anaconda-mode)
(defconst anaconda-mode-installation-directory (concat user-temp-dir "anaconda-mode"))

(with-eval-after-load 'company
  (fetch-package 'company-anaconda)
  (require 'company-anaconda)
  (defun python/add-anaconda-to-company()
    "添加 anaconda-mode 的 company 后端"
    (completion/push-local-company-backend 'company-anaconda))
  (add-hook 'python-mode-hook 'python/add-anaconda-to-company))

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(provide 'init-python)
;;;  init-python.el ends here
