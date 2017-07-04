;;; Package -- Python开发环境
;;; Commentary:
;;; Code:


(add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))


(defun ipython-install-p (path)
  "判断指定 PATH 是否存在 ipython, 不存在则为nil."
  (let ((rtn (replace-regexp-in-string "\n" "" (shell-command-to-string (concat path "ipython -c \"exit()\"")))))
    (if (or (string= rtn "") (string-match "UserWarning:" rtn) (string-match "IPython:" rtn))
	rtn
      nil
      )
    )
  )


;; PyEnv支持
(with-eval-after-load 'exec-path-from-shell
  (exec-path-from-shell-copy-env "PYENV_ROOT")
  )

(defvar-local pyenv-version nil "Buffer Local变量，如果版本存在则为版本信息，否则为nil.")
(defvaralias 'pyenv-shell-virtualenv-root
  (if (boundp 'python-shell-virtualenv-root)
      'python-shell-virtualenv-root
    'python-shell-virtualenv-path)
  "Virtualenv变量别名.")

(defun pyenv-install-p ()
  "判断是否存在pyenv, 不存在则为nil."
  (let ((pyenv-rtn (replace-regexp-in-string "\n" "" (shell-command-to-string "which pyenv"))))
    (if (not (string= pyenv-rtn ""))
	t
      )
    )
  )

(defun pyenv-root ()
  "获得pyenv的root路径."
  (replace-regexp-in-string "\n" "" (shell-command-to-string "pyenv root"))
  )

(defun pyenv-current-version()
  "Pyenv当前版本."
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

(defun pyenv-ipython-install-p (version)
  "判断指定 VERSION 是否存在ipython, 不存在则为nil."
  (ipython-install-p (concat (pyenv-version-bin-absolute-path version)))
  )

(defmacro pyenv-command-run (version command &rest args)
  "运行指定版本 VERSION 的 COMMAND 及参数 ARGS."
  `(start-process (format "pyenv-%s" ,version)
		  (format "*pyenv-%s*" ,version)
		  (concat (pyenv-version-bin-absolute-path ,version) ,command)
		  ,@args)
  )

(defun pyenv-mode-line-format-update ()
  "设置 mode-line 显示信息."
  (if pyenv-version
      (progn
	(setq-local pyenv-mode-line-format '(:eval (when (and (boundp 'pyenv-version) pyenv-version) (format "(%s) " pyenv-version))))
	(add-to-list 'mode-line-misc-info pyenv-mode-line-format)
	)
    (setq mode-line-misc-info (delete pyenv-mode-line-format mode-line-misc-info))
    )
  )

(defun pyenv-activate (version)
  "激活版本 VERSION 的虚拟环境."
  (when version
    (setq-local pyenv-version version)
    (setq-local pyenv-shell-virtualenv-root (pyenv-version-absolute-path version))
    (if (pyenv-ipython-install-p version)
	(progn
	  (setq-local python-shell-interpreter "ipython")
	  (setq-local python-shell-buffer-name "IPython")
	  (setq-local python-shell-process-environment '("LANG=en_US.UTF8"
							 "PYTHONIOENCODING=utf-8"
							 "IPY_TEST_SIMPLE_PROMPT=1"))
	  (setq-local python-shell-completion-native-enable nil)
	  (setq-local python-shell-prompt-regexp "In \\[[0-9]+\\]: ")
	  )
      (message "当前版本[%s]下未安装ipython，请安装以获得自动补全功能.")
      )
    )
  )


(config-add-hook 'python-mode-hook
  (if (pyenv-install-p)
      (progn
	(pyenv-activate (pyenv-current-version))
	(pyenv-mode-line-format-update)
	)
    (progn
      (if (ipython-install-p "")
	  (progn
	    (setq-local python-shell-interpreter "ipython")
	    (setq-local python-shell-buffer-name "IPython")
	    (setq-local python-shell-process-environment '("LANG=en_US.UTF8"
							   "PYTHONIOENCODING=utf-8"
							   "IPY_TEST_SIMPLE_PROMPT=1"))
	    (setq-local python-shell-completion-native-enable nil)
	    (setq-local python-shell-prompt-regexp "In \\[[0-9]+\\]: ")
	    )
	(message "未安装ipython，无法获得自动补全功能")
	)
      )
    )

  (with-eval-after-load 'yasnippet
    (yasnippet/add-buffer-local-company-backend)
    )
  )

(provide 'init-python)
;;;  init-python.el ends here
