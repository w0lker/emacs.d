;;; package -- 代码补全
;;; Commentary:
;;; Code:

;; 补全样式
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html
;; 使用这个样式可以补全首字母缩写，如:使用lch补全list-command-history
(add-to-list 'completion-styles 'initials t)

;;; 模版补全
(require-package 'yasnippet)
(require-package 'dropdown-list)
;; 配置提示位置
(setq yas-prompt-functions '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))

;; 设置个性化snippets目录为.snippets
(setq yas-snippet-dirs (expand-file-name ".snippets" user-emacs-directory))
(when (file-exists-p custom-yas-snippets-dir)
    (message "hello %s" custom-yas-snippets-dir)
    (setq yas-snippet-dirs custom-yas-snippets-dir))

;; 添加到lisp环境，方便在snippets中使用lisp代码编写模版
(add-to-list 'load-path yas-snippet-dirs)
(yas-global-mode 1)
(with-eval-after-load 'yas-minor-mode
  (diminish 'yas-minor-mode))

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
      company-idle-delay .5 ;; 补全延迟
      )

(when (require-package 'company)
  (add-hook 'after-init-hook 'global-company-mode)
  (with-eval-after-load 'company
    (diminish 'company-mode)
    (define-key company-mode-map (kbd "M-/") 'company-complete)
    (define-key company-active-map (kbd "M-/") 'company-select-next)
    (setq-default company-backends '((company-capf company-dabbrev-code) company-dabbrev))))

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

;; 文档弹出，只在使用桌面系统时使用
(when window-system
  (with-eval-after-load 'company
    (require-package 'company-quickhelp)
    (company-quickhelp-mode 1)
    (setq company-quickhelp-delay nil)
    (define-key company-active-map (kbd "M-h") #'company-quickhelp-manual-begin)))

;; 工具函数
(defun my/company/local-push-company-backend (backend)
  "Add BACKEND to a buffer-local version of `company-backends'."
  (set (make-local-variable 'company-backends)
       (append (list backend) company-backends)))

(provide 'init-completion)
;;; init-completion.el ends here
