;;; package -- 苹果配置
;;; Commentary:
;;; Code:

(fetch-package 'exec-path-from-shell)

(defconst *is-a-mac* (eq system-type 'darwin))

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta))

;; 使用C-M-f触发全屏模式
(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  (global-set-key (kbd "C-M-f") 'toggle-frame-fullscreen))

;; 同步 emacs 环境变量 shell 环境变量
(require 'exec-path-from-shell)
(if (memq window-system '(mac ns))
    (progn
      (dolist (var '("TERM" "SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE"))
	(add-to-list 'exec-path-from-shell-variables var))
      (exec-path-from-shell-initialize)))

(provide 'init-osx)
;;;  init-osx.el ends here
