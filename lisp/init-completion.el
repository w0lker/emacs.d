;;; package -- 代码补全配置
;;; Commentary:
;;; Code:

;; 设置补全样式
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html
;; 使用这个样式可以补全首字母缩写，如:使用lch补全list-command-history
(add-to-list 'completion-styles 'initials t)

;;; hippie-expand方式补全
;; 设置补全，针对已经出现过的符号
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))
(global-set-key (kbd "M-/") 'hippie-expand)

;;; company方式补全
;; 基本
(setq tab-always-indent 'complete
      completion-cycle-threshold 5
      company-idle-delay 0.1)

;; 主题
(let ((bg (face-attribute 'default :background)))
  (custom-set-faces
   `(company-tooltip ((t :inherit default :background "#403D3D")))
   `(company-scrollbar-bg ((t :background "#232526")))
   `(company-scrollbar-fg ((t :background "#E6DB74")))
   `(company-preview ((t :background "color-66")))
   `(company-preview-search ((t :background "color-66")))
   `(company-tooltip-selection ((t :inherit font-lock-function-name-face)))
   `(company-tooltip-common ((t :inherit font-lock-constant-face)))
   '(font-lock-comment-face ((t (:foreground "#888888" :slant italic))))
   ))

(when (maybe-require-package 'company)
  (add-hook 'after-init-hook 'global-company-mode)
  (after-load 'company
    (diminish 'company-mode)
    (define-key company-mode-map (kbd "M-/") 'company-complete)
    (define-key company-active-map (kbd "M-/") 'company-select-next)
    (setq-default company-backends '((company-capf company-dabbrev-code) company-dabbrev))))

;; company中停用page-break-lines-mode
;; Suspend page-break-lines-mode while company menu is active
;; (see https://github.com/company-mode/company-mode/issues/416)
(after-load 'company
  (after-load 'page-break-lines-mode
    (defvar my/completion/page-break-lines-on-p nil)
    (make-variable-buffer-local 'my/completion/page-break-lines-on-p)

    (defun my/completion/page-break-lines-disable (&rest ignore)
      (when (setq my/completion/page-break-lines-on-p (bound-and-true-p page-break-lines-mode))
        (page-break-lines-mode -1)))

    (defun my/completion/page-break-lines-maybe-reenable (&rest ignore)
      (when my/completion/page-break-lines-on-p
        (page-break-lines-mode 1)))

    (add-hook 'company-completion-started-hook 'my/completion/page-break-lines-disable)
    (add-hook 'company-completion-finished-hook 'my/completion/page-break-lines-maybe-reenable)
    (add-hook 'company-completion-cancelled-hook 'my/completion/page-break-lines-maybe-reenable)))

;; 只在使用桌面系统时使用
(when window-system
  (when (maybe-require-package 'company-quickhelp)
    (add-hook 'after-init-hook 'company-quickhelp-mode))
  (setq company-quickhelp-delay 0.5))

(defun my/company/local-push-company-backend (backend)
  "Add BACKEND to a buffer-local version of `company-backends'."
  (set (make-local-variable 'company-backends)
       (append (list backend) company-backends)))

(provide 'init-completion)
;;; init-completion.el ends here
