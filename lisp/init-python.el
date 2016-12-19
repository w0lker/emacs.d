;;; Package -- Python开发环境
;;; Commentary:
;;; Code:

;; 关联文件
(add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("SConscript\\'" . python-mode))

;; 设置 python-mode
(setq python-shell-interpreter "ipython")
(setq python-shell-completion-native-enable nil)
(setq python-shell-prompt-regexp "In \\[[0-9]+\\]: ")
(setq python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: ")

;; 解决“ansi-color-filter-apply: Args out of range”这个问题
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")

;; 提供代码补全
(require-package 'anaconda-mode)
(setq-default anaconda-mode-installation-directory (concat user-emacs-directory (file-name-as-directory my-temp-dir) "anaconda-mode"))
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(defun my/python/add-anaconda-to-company()
  "添加 anaconda-mode 的 company 后端"
  (require 'company)
  (my/completion/push-local-company-backend 'company-anaconda))
(add-hook 'python-mode-hook 'my/python/add-anaconda-to-company)

;; 虚拟环境
(require-package 'pyenv-mode)
(require-package 'pyenv-mode-auto)
(require 'pyenv-mode-auto)

(defun my/python/config-python-environment-variables ()
  "配置 python 环境变量，添加环境变量 PYENV_ROOT 和 PATH."
  (make-local-variable 'process-environment)
  (with-temp-buffer
    (call-process "bash" nil t nil "-c" "source ~/.bash_profile; env|egrep 'PYENV_ROOT|PATH'")
    (goto-char (point-min))
    (while (not (eobp))
      (setq process-environment (cons (buffer-substring (point) (line-end-position)) process-environment))
      (forward-line 1))))
(add-hook 'python-mode-hook 'my/python/config-python-environment-variables)

;; 提供PyPI补全
(require-package 'pip-requirements)

(provide 'init-python)
;;;  init-python.el ends here
