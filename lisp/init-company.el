;; 设置补全company插件

(setq tab-always-indent 'complete)  ;; use 't when company is disabled
(add-to-list 'completion-styles 'initials t)
;; Stop completion-at-point from popping up completion buffers so eagerly
(setq completion-cycle-threshold 5)


(when (maybe-require-package 'company)
  (add-hook 'after-init-hook 'global-company-mode)
  (after-load 'company
    (diminish 'company-mode "CMP")
    (define-key company-mode-map (kbd "M-/") 'company-complete)
    (define-key company-active-map (kbd "M-/") 'company-select-next)
    (setq-default company-backends '((company-capf company-dabbrev-code) company-dabbrev)))
  (global-set-key (kbd "M-C-/") 'company-complete)
  (when (maybe-require-package 'company-quickhelp)
    (after-load 'company-quickhelp
      (define-key company-quickhelp-mode-map (kbd "M-h") nil))
    (add-hook 'after-init-hook 'company-quickhelp-mode))


  (defun my/local-push-company-backend (backend)
    "Add BACKEND to a buffer-local version of `company-backends'."
    (set (make-local-variable 'company-backends)
         (append (list backend) company-backends))))


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



(provide 'init-company)
