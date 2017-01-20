;;; package -- 苹果配置
;;; Commentary:
;;; Code:

(defconst *is-a-mac* (eq system-type 'darwin))

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta)
  )

;; 使用C-M-f触发全屏模式
(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  (global-set-key (kbd "C-M-f") 'toggle-frame-fullscreen))

;; 同步 emacs 环境变量 shell 环境变量
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config
  (dolist (var '("TERM" "SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize)
  )

(provide 'init-mac)
;;;  init-mac.el ends here
