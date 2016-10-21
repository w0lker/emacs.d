;;; Package -- Python configurations.
;;; Commentary:
;;; Code:

(diminish 'python-mode "PY")

(require-package 'elpy)
(elpy-enable)
(elpy-use-ipython)
(setq elpy-rpc-backend "jedi")

(require-package 'pyenv-mode)
(require-package 'pyenv-mode-auto)
(require 'pyenv-mode-auto)

;; Syntax checking
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; PEP8 compliance
(require-package 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(provide 'init-python)
;;;  init-python.el ends here
