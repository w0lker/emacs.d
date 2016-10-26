;;; Package -- Python开发环境配置
;;; Commentary:
;;; Code:

;; 添加环境变量
(setenv "PYENV_ROOT"
        (let ((current (getenv "PYENV_ROOT"))
              (new "/usr/local/var/pyenv"))
          (if current (concat new ":" current) new)))

(setenv "WORKON_HOME"
        (let ((current (getenv "WORKON_HOME"))
              (new "/usr/local/var/pyenv/versions"))
          (if current (concat new ":" current) new)))

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)

(when (maybe-require-package 'anaconda-mode)
  (after-load 'python
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
  (when (maybe-require-package 'company-anaconda)
    (after-load 'company
      (add-hook 'python-mode-hook
                (lambda () (my/local-push-company-backend 'company-anaconda))))))

(setq python-shell-interpreter "ipython")

(require-package 'pyenv-mode)
(require-package 'pyenv-mode-auto)
(require 'pyenv-mode-auto)

(when (require-package 'py-yapf) (require 'py-yapf))

(provide 'init-python)
;;;  init-python.el ends here
