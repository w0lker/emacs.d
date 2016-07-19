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
