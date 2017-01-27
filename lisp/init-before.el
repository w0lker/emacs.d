;;; package -- 基础工具和配置
;;; Commentary:
;;; Code:

(fetch-package 'cl-lib)
(fetch-package 'fullframe)
(fetch-package 'diminish)
(fetch-package 'scratch)
(fetch-package 'mwe-log-commands)
(fetch-package 'wgrep)
(fetch-package 'project-local-variables)
(fetch-package 'mmm-mode)
(fetch-package 'guide-key)
(fetch-package 'evil)
(fetch-package 'evil-leader)
(fetch-package 'evil-surround)

(eval-when-compile (require 'cl))
(require 'fullframe)
(require 'diminish)
(require 'scratch)
(require 'mwe-log-commands)
(require 'wgrep)
(require 'project-local-variables)

(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
(guide-key-mode t)
(diminish 'guide-key-mode)

(setq help-window-select t)


(require 'evil)
(setq-default evil-default-state 'normal)
(evil-mode t)
(defun evil/emacs-mode-config()
  "当使用 emacs 模式时光标转换为竖线."
 (setq-local cursor-type '(bar . 2)))
(add-hook 'evil-emacs-state-entry-hook 'evil/emacs-mode-config)
(require 'evil-leader)(setq-default evil-leader/leader "\\")
(setq-default evil-leader/in-all-states t)
(evil-leader/set-key "q" 'kill-buffer)
(evil-leader/set-key "w" 'save-buffer)
(evil-leader/set-key "l" 'linum-mode)
(global-evil-leader-mode t)
(require 'evil-surround)
(global-evil-surround-mode t)

(provide 'init-before)
;;;  init-before.el ends here
