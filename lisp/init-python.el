;;; Package -- Python开发环境
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(defcustom pyenv-version nil
  "设置pyenv-version版本信息，默认为nil.
该值绝大不分时候不用手动设置有函数自己确定版本.")

(defvaralias 'pyenv-shell-virtualenv-root
  (if (boundp 'python-shell-virtualenv-root)
      'python-shell-virtualenv-root
    'python-shell-virtualenv-path)
  "Virtualenv变量别名.")

(defun pyenv-install-p ()
  "判断是否存在pyenv, 不存在则为nil."
  (replace-regexp-in-string "\n" "" (shell-command-to-string "which pyenv"))
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

(defun pyenv-bin-absolute-path (version)
  "返回指定VERSION的bin全路径."
  (file-name-as-directory (concat (pyenv-version-absolute-path version) "/bin/"))
  )

(defun pyenv-ipython-install-p (version)
  "判断指定 VERSION 是否存在ipython, 不存在则为nil."
  (let ((return-result (replace-regexp-in-string "\n" "" (shell-command-to-string (concat (pyenv-bin-absolute-path version) "ipython -c \"exit()\"")))))
    (if (or (string= return-result "") (string-match "UserWarning:" return-result) (string-match "IPython:" return-result))
	return-result
      (progn
	(message "IPython 安装错误: %s" return-result)
	nil
	)
      )
    )
  )

(defmacro pyenv-command-run (version command &rest args)
  "运行指定版本 VERSION 的 COMMAND 及参数 ARGS."
  `(start-process (format "pyenv-%s" ,version)
		  (format "*pyenv-%s*" ,version)
		  (concat (pyenv-bin-absolute-path ,version) ,command)
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
      (message "IPython 没有安装，请在当前版本下安装.")
      )
    )
  )

(config-add-hook 'python-mode-hook
  (when (pyenv-install-p)
    (pyenv-activate (pyenv-current-version))
    (pyenv-mode-line-format-update)
    )
  )

(provide 'init-python)
;;;  init-python.el ends here
