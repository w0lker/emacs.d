;;; package -- Evil 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'evil
  (evil-mode t)
  (setq evil-default-state 'normal)

  (config-add-hook 'evil-emacs-state-entry-hook
    ;; 当使用 emacs 模式时光标转换为竖线
    (setq-local cursor-type '(bar . 2))
    )

  (config-after-fetch-require 'evil-leader
    (setq-default evil-leader/leader "\\")
    (setq-default evil-leader/in-all-states t)
    (evil-leader/set-key "q" 'kill-buffer)
    (evil-leader/set-key "w" 'save-buffer)
    (evil-leader/set-key "l" 'linum-mode)
    (global-evil-leader-mode t)
    )

  (config-after-fetch-require 'evil-surround
    (global-evil-surround-mode t)
    )
  )

(provide 'init-evil)
;;;  init-evil.el ends here
