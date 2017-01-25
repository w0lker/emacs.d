;;; Package -- Python开发环境
;;; Commentary:
;;; Code:

(fetch-package 'python)
(fetch-package 'pyenv-mode)
(fetch-package 'pyenv-mode-auto)
(fetch-package 'anaconda-mode)
(fetch-package 'company-anaconda)

(add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(require 'python)

;; 解决 “ansi-color-filter-apply: Args out of range” 这个问题
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
(setq python-shell-interpreter "ipython")
(setq python-shell-completion-native-enable nil)
(setq python-shell-prompt-regexp "In \\[[0-9]+\\]: ")

(defun python/environment-variables-config ()
  "配置 python 环境变量，添加环境变量 PYENV_ROOT 和 PATH."
  (make-local-variable 'process-environment)
  (with-temp-buffer
    (call-process "bash" nil t nil "-c" "source ~/.bash_profile; env|egrep 'PYENV_ROOT|PATH'")
    (goto-char (point-min))
    (while (not (eobp))
      (setq process-environment (cons (buffer-substring (point) (line-end-position)) process-environment))
      (forward-line 1))))
(add-hook 'python-mode-hook 'python/environment-variables-config)

(require 'pyenv-mode)
(require 'pyenv-mode-auto)

(require 'anaconda-mode)
(defconst anaconda-mode-installation-directory (concat user-temp-dir "anaconda-mode"))

(with-eval-after-load 'company
  (require 'company-anaconda)
  (defun python/add-anaconda-to-company()
    "添加 anaconda-mode 的 company 后端"
    (completion/push-local-company-backend 'company-anaconda))
  (add-hook 'python-mode-hook 'python/add-anaconda-to-company))

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(provide 'init-python)
;;;  init-python.el ends here
