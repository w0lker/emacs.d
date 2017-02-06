;;; package -- 最后加载配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'exec-path-from-shell
  (if (memq window-system '(mac ns))
      (progn
	(dolist (var '("TERM" "SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "PATH" "PYENV_ROOT" "GOPATH" "GOROOT"))
	  (add-to-list 'exec-path-from-shell-variables var))
	(exec-path-from-shell-initialize)))
  )

(config-after-fetch-require 'mmm-mode
  (setq mmm-global-mode 'buffers-with-submode-classes)
  (setq mmm-submode-decoration-level 2)
  )

(defun after/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match "UTF-8" v)))

(defun after/locale-is-utf8-p ()
  "Return t if the \"locale\" command or environment variables prefer UTF-8."
  (or (after/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (after/utf8-locale-p (getenv "LC_ALL"))
      (after/utf8-locale-p (getenv "LC_CTYPE"))
      (after/utf8-locale-p (getenv "LANG"))))

(when (or window-system (after/locale-is-utf8-p))
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
  (prefer-coding-system 'utf-8)
  )

(provide 'init-after)
;;;  init-after.el ends here
