;;; Package -- Python开发环境
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(with-eval-after-load 'exec-path-from-shell
  (exec-path-from-shell-copy-env "PYENV_ROOT")
  )

(defun ipython-config ()
  "设置ipython配置."
  (setq-local python-shell-interpreter "ipython")
  (setq-local python-shell-buffer-name "IPython")
  (setq-local python-shell-process-environment '("LANG=en_US.UTF8"
						 "PYTHONIOENCODING=utf-8"
						 "IPY_TEST_SIMPLE_PROMPT=1"))
  (setq-local python-shell-completion-native-enable nil)
  (setq-local python-shell-prompt-regexp "In \\[[0-9]+\\]: ")
  )

(defvaralias 'pyenv-shell-virtualenv-root
  (if (boundp 'python-shell-virtualenv-root)
      'python-shell-virtualenv-root
    'python-shell-virtualenv-path
    )
  "Virtualenv变量别名.")

(defun pyenv-root ()
  "获得pyenv的root路径."
  (replace-regexp-in-string "\n" "" (shell-command-to-string "pyenv root"))
  )

(defun pyenv-current-version()
  "获得pyenv当前版本."
  (replace-regexp-in-string "\n" "" (shell-command-to-string "pyenv version-name"))
  )

(defun pyenv-version-absolute-path (version)
  "返回指定VERSION的全路径."
  (unless (string= version "system")
    (concat (pyenv-root) "/versions/" version))
  )

(defun pyenv-version-bin-absolute-path (version)
  "返回指定VERSION的bin全路径."
  (file-name-as-directory (concat (pyenv-version-absolute-path version) "/bin/"))
  )

(defun pyenv-command-install-p (version command)
  "判断指定 VERSION 是否存在 COMMAND, 不存在则为nil."
  (executable-find (concat (pyenv-version-bin-absolute-path version) "/" command))
  )

(defun pyenv-mode-line-format-update (version)
  "设置 mode-line 显示 VERSION 信息."
  (if version
      (progn
	(setq-local pyenv-version version)
	(setq-local pyenv-mode-line-format '(:eval (when (and (boundp 'pyenv-version) pyenv-version) (format "(%s) " pyenv-version))))
	(add-to-list 'mode-line-misc-info pyenv-mode-line-format)
	)
    (setq mode-line-misc-info (delete pyenv-mode-line-format mode-line-misc-info))
    )
  )

(defun pyenv-activate (version)
  "激活版本 VERSION 的虚拟环境."
  (when version
    (setq-local pyenv-shell-virtualenv-root (pyenv-version-absolute-path version))
    (if (pyenv-command-install-p version "ipython")
	(ipython-config)
      (message "当前版本[%s]下未安装ipython，请安装以获得自动补全功能." version)
      )
    (pyenv-mode-line-format-update version)
    )
  )

(config-add-hook 'python-mode-hook
  (setq indent-tabs-mode t
	      tab-width 4
	      py-indent-tabs-mode t
	      )
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)

  (if (executable-find "pyenv")
      (pyenv-activate (pyenv-current-version))
    (progn
      (if (executable-find "ipython")
	  (ipython-config)
	(message "未安装ipython，无法获得自动补全功能")
	)
      )
    )

  (yasnippet/add-buffer-local-company-backend)
  )

(provide 'init-python)
;;;  init-python.el ends here
