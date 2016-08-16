;;; package -- python configure
;;; Commentary:
;;; Code:


(require-package 'elpy)
(elpy-enable)


;; flycheck配置
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; 添加pep8规范自动格式化
(require-package 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; 使用ipython
(elpy-use-ipython)


(provide 'init-python)
;;;  init-python.el ends here
