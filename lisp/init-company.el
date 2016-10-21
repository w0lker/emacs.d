;;; package -- company配置文件
;;; Commentary:
;;; Code:

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)
(setq completion-cycle-threshold 3)
(setq company-idle-delay 0)

(when (maybe-require-package 'company)
  (add-hook 'after-init-hook 'global-company-mode)
  (after-load 'company
    (diminish 'company-mode "CMP")
    (define-key company-mode-map (kbd "M-/") 'company-complete)
    (define-key company-active-map (kbd "M-/") 'company-select-next)
    (setq-default company-backends '((company-capf company-dabbrev-code) company-dabbrev)))
  (global-set-key (kbd "M-C-/") 'company-complete))

(when (maybe-require-package 'company-quickhelp)
  (add-hook 'after-init-hook 'company-quickhelp-mode))

(defun my/local-push-company-backend (backend)
  "Add BACKEND to a buffer-local version of `company-backends'."
  (set (make-local-variable 'company-backends)
       (append (list backend) company-backends)))

;; Suspend page-break-lines-mode while company menu is active
;; (see https://github.com/company-mode/company-mode/issues/416)
(after-load 'company
  (after-load 'page-break-lines-mode
    (defvar my/page-break-lines-on-p nil)
    (make-variable-buffer-local 'my/page-break-lines-on-p)

    (defun my/page-break-lines-disable (&rest ignore)
      (when (setq my/page-break-lines-on-p (bound-and-true-p page-break-lines-mode))
        (page-break-lines-mode -1)))

    (defun my/page-break-lines-maybe-reenable (&rest ignore)
      (when my/page-break-lines-on-p
        (page-break-lines-mode 1)))

    (add-hook 'company-completion-started-hook 'my/page-break-lines-disable)
    (add-hook 'company-completion-finished-hook 'my/page-break-lines-maybe-reenable)
    (add-hook 'company-completion-cancelled-hook 'my/page-break-lines-maybe-reenable)))


;; 主题配置
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

(provide 'init-company)
;;; init-company.el ends here
