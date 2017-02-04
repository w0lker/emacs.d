;;; package -- 基础工具和配置
;;; Commentary:
;;; Code:


(fetch-package 'cl-lib)
(require 'cl-lib)
(with-eval-after-load 'cl-lib
  (eval-when-compile (require 'cl))
  )

(fetch-package 'mmm-mode)
(require 'mmm-auto)
(with-eval-after-load 'mmm-auto
  (setq mmm-global-mode 'buffers-with-submode-classes)
  (setq mmm-submode-decoration-level 2)
  )

(fetch-package 'fullframe)
(fetch-package 'diminish)
(fetch-package 'scratch)
(fetch-package 'mwe-log-commands)
(fetch-package 'wgrep)
(fetch-package 'project-local-variables)

(fetch-package 'guide-key)
(require 'guide-key)
(with-eval-after-load 'guide-key
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (guide-key-mode t)
  (diminish 'guide-key-mode)
  )

(setq help-window-select t)

(fetch-package 'evil)
(require 'evil)
(with-eval-after-load 'evil
  (setq-default evil-default-state 'normal)
  (evil-mode t)

  (defun before/evil-emacs-mode-config()
    "当使用 emacs 模式时光标转换为竖线."
    (setq-local cursor-type '(bar . 2)))
  (add-hook 'evil-emacs-state-entry-hook 'before/evil-emacs-mode-config)

  (fetch-package 'evil-leader)
  (require 'evil-leader)
  (setq-default evil-leader/leader "\\")
  (setq-default evil-leader/in-all-states t)
  (evil-leader/set-key "q" 'kill-buffer)
  (evil-leader/set-key "w" 'save-buffer)
  (evil-leader/set-key "l" 'linum-mode)
  (global-evil-leader-mode t)

  (fetch-package 'evil-surround)
  (require 'evil-surround)
  (global-evil-surround-mode t)
  )

(provide 'init-before)
;;;  init-before.el ends here
