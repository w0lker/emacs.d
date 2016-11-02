;;; package -- 代码补全配置
;;; Commentary:
;;; Code:

;; 补全样式
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html
;; 使用这个样式可以补全首字母缩写，如:使用lch补全list-command-history
(add-to-list 'completion-styles 'initials t)

;;; 模版补全
(require-package 'yasnippet)
(require-package 'dropdown-list)
(add-to-list 'load-path (expand-file-name "snippets" user-emacs-directory))

(setq yas-prompt-functions '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))
(yas-global-mode 1)
(diminish 'yas-minor-mode)

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
(setq tab-always-indent 'complete
      completion-cycle-threshold 5
      company-idle-delay .6 ;; 补全延迟
      )

;; company主题
(custom-set-faces
 '(company-tooltip ((t :background "#403d3d"))) ;; 弹窗背景
 '(company-tooltip-selection ((t :foreground "#f62d6e" :background "#525151"))) ;; 选中选项颜色
 '(company-tooltip-common ((t :foreground "#f62d6e"))) ;; 前缀部分
 '(company-tooltip-common-selection ((t :foreground "#f62d6e"))) ;; 前缀选中部分
 '(company-tooltip-annotation ((t :foreground "#92e56d"))) ;; 注解部分
 '(company-scrollbar-bg ((t :background "#403d3d"))) ;; 进度条背景色
 '(company-scrollbar-fg ((t :background "#f8f7f1"))) ;; 进度条前景色
 )

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

(defun my/company/local-push-company-backend (backend)
  "Add BACKEND to a buffer-local version of `company-backends'."
  (set (make-local-variable 'company-backends)
       (append (list backend) company-backends)))

;; 只在使用桌面系统时使用
(when window-system
  (require-package 'company-quickhelp)
  (company-quickhelp-mode 1)
  (setq company-quickhelp-delay nil)
  (eval-after-load 'company
    '(define-key company-active-map (kbd "M-h") #'company-quickhelp-manual-begin)))

(provide 'init-completion)
;;; init-completion.el ends here
