;;; package -- Vim 快捷键
;;; Commentary:
;;; Code:

(fetch-package 'evil)
(fetch-package 'evil-leader)
(fetch-package 'evil-surround)

(require 'evil)
(setq-default evil-default-state 'normal)
(evil-mode t)

(defun evil/emacs-mode-config()
  "当使用 emacs 模式时光标转换为竖线."
  (setq-local cursor-type '(bar . 2)))
(add-hook 'evil-emacs-state-entry-hook 'evil/emacs-mode-config)

(require 'evil-leader)
(setq-default evil-leader/leader "\\")
(setq-default evil-leader/in-all-states t)
(evil-leader/set-key "q" 'kill-buffer)
(evil-leader/set-key "w" 'save-buffer)
(evil-leader/set-key "l" 'linum-mode)
(global-evil-leader-mode)

(require 'evil-surround)
(global-evil-surround-mode t)

(provide 'init-evil)
;;;  init-evil.el ends here
