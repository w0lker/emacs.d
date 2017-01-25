;;; package -- 代码补全
;;; Commentary:
;;; Code:

(fetch-package 'yasnippet)
(fetch-package 'dropdown-list)
(fetch-package 'company)
(fetch-package 'company-quickhelp)

(setq tab-always-indent 'complete)
(setq completion-cycle-threshold 5)
(add-to-list 'completion-styles 'initials t)

(diminish 'abbrev-mode)

(require 'yasnippet)
(require 'dropdown-list)
(defconst completion/yas-snippet-dirs (expand-file-name ".snippets" user-emacs-directory))
(setq yas-snippet-dirs completion/yas-snippet-dirs)
(setq yas-prompt-functions '(yas-dropdown-prompt
			     yas-ido-prompt
			     yas-completing-prompt))
(add-to-list 'load-path completion/yas-snippet-dirs)
(yas-global-mode t)
(diminish 'yas-minor-mode)

(setq hippie-expand-try-functions-list '(try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill))
(global-set-key (kbd "M-/") 'hippie-expand)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(setq company-idle-delay .5
      company-minimum-prefix-length 2)

(with-eval-after-load 'company
  (setq-default company-backends '((company-capf company-dabbrev-code) company-dabbrev company-files))
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-select-next)
  (diminish 'company-mode)

  (with-eval-after-load 'evil
    (evil-declare-change-repeat 'company-complete)))

(custom-set-faces
 '(company-tooltip ((t :background "#403d3d"))) ;; 弹窗背景
 '(company-tooltip-selection ((t :foreground "#f62d6e" :background "#525151"))) ;; 选中选项颜色
 '(company-tooltip-common ((t :foreground "#f62d6e"))) ;; 前缀部分
 '(company-tooltip-common-selection ((t :foreground "#f62d6e"))) ;; 前缀选中部分
 '(company-tooltip-annotation ((t :foreground "#92e56d"))) ;; 注解部分
 '(company-scrollbar-bg ((t :background "#403d3d")))
 '(company-scrollbar-fg ((t :background "#f8f7f1"))))

(require 'company-quickhelp)
(if window-system
    (progn
      (setq company-quickhelp-delay nil)
      (company-quickhelp-mode t)
      (define-key company-active-map (kbd "M-h") 'company-quickhelp-manual-begin))
  )

(defun completion/push-local-company-backend (backend)
  "添加 BACKEND 到 buffer 级别的 `company-backends'."
  (setq-local company-backends (append (list backend) company-backends)))

(provide 'init-completion)
;;; init-completion.el ends here
