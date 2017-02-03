;;; package -- 基础工具和配置
;;; Commentary:
;;; Code:

(fetch-package 'cl-lib)
(fetch-package 'mmm-mode)
(fetch-package 'fullframe)
(fetch-package 'diminish)
(fetch-package 'scratch)
(fetch-package 'mwe-log-commands)
(fetch-package 'wgrep)
(fetch-package 'project-local-variables)
(fetch-package 'ido)
(fetch-package 'ido-yes-or-no)
(fetch-package 'ido-ubiquitous)
(fetch-package 'crm-custom)
(fetch-package 'smex)
(fetch-package 'guide-key)
(fetch-package 'evil)
(fetch-package 'evil-leader)
(fetch-package 'evil-surround)

(require 'cl-lib)
(eval-when-compile (require 'cl))

(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)

(require 'fullframe)
(require 'diminish)
(require 'scratch)
(require 'mwe-log-commands)
(require 'wgrep)
(require 'project-local-variables)

(require 'ido)
(with-eval-after-load 'ido
  (ido-mode 1)
  (ido-everywhere 1)
  (defconst ido-save-directory-list-file (concat user-temp-dir "ido.last")) ;; 保存目录
  (setq ido-enable-flex-matching t) ;; 非常开放的匹配方式 aa 可以匹配 alpha
  (setq ido-enable-regexp t) ;; 支持正则表达式
  (setq ido-use-filename-at-point nil)
  (setq ido-auto-merge-work-directories-length -1)
  (setq ido-use-virtual-buffers t)
  (setq ido-default-buffer-method 'selected-window) ;; 允许一个 buffer 同时在不同的的 frame 中打开

  ;; 支持 M-x 命令自动补全
  (require 'smex)
  (defconst smex-save-file (concat user-temp-dir "smex-items"))
  (global-set-key [remap execute-extended-command] 'smex)

  ;; 尽量让 ido 支持更多场景的补全
  (require 'ido-ubiquitous)
  (ido-ubiquitous-mode 1)

  (require 'ido-yes-or-no)
  (ido-yes-or-no-mode 1)

  (require 'crm-custom)
  (crm-custom-mode 1)
  )

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
(guide-key-mode t)
(diminish 'guide-key-mode)

(setq help-window-select t)

(require 'evil)
(with-eval-after-load 'evil
  (setq-default evil-default-state 'normal)
  (evil-mode t)

  (defun before/evil-emacs-mode-config()
    "当使用 emacs 模式时光标转换为竖线."
    (setq-local cursor-type '(bar . 2)))
  (add-hook 'evil-emacs-state-entry-hook 'before/evil-emacs-mode-config)

  (require 'evil-leader)
  (setq-default evil-leader/leader "\\")
  (setq-default evil-leader/in-all-states t)
  (evil-leader/set-key "q" 'kill-buffer)
  (evil-leader/set-key "w" 'save-buffer)
  (evil-leader/set-key "l" 'linum-mode)
  (global-evil-leader-mode t)

  (require 'evil-surround)
  (global-evil-surround-mode t)
  )

(provide 'init-before)
;;;  init-before.el ends here
