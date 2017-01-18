;;; package -- Vim 快捷键
;;; Commentary:
;;; Code:

(use-package evil
  :ensure t
  :init
  (setq-default evil-default-state 'normal)
  :config
  (evil-mode 1)

  (defun evil/emacs-mode-config()
    "当使用 emacs 模式时光标转换为竖线."
    (setq-local cursor-type '(bar . 2)))
  (add-hook 'evil-emacs-state-entry-hook 'evil/emacs-mode-config)

  (use-package evil-leader
    :ensure t
    :init
    (setq-default evil-leader/leader "\\")
    (setq-default evil-leader/in-all-states t)
    :config
    (evil-leader/set-key "q" 'kill-buffer)
    (evil-leader/set-key "w" 'save-buffer)
    (evil-leader/set-key "l" 'linum-mode)
    (global-evil-leader-mode)
    )

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1)
    )
  )

(provide 'init-evil)
;;;  init-evil.el ends here
