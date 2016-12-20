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
;; 设置个性化 snippets 目录
(setq-default yas-snippet-dirs (expand-file-name ".snippets" user-emacs-directory))
;; 添加 snippets 到 load-path
(add-to-list 'load-path yas-snippet-dirs)
(yas-global-mode 1)
(with-eval-after-load 'yasnippet (diminish 'yas-minor-mode))

;; 已经出现过的符号补全
(setq hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill))
(global-set-key (kbd "M-/") 'hippie-expand)

;;; Company 补全
(setq tab-always-indent 'complete)
(setq completion-cycle-threshold 5)
(setq company-idle-delay .5)

(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends '((company-capf company-dabbrev-code) company-dabbrev))
;; 按键绑定
(with-eval-after-load 'company
  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key company-active-map (kbd "M-/") 'company-select-next))
(with-eval-after-load 'company (diminish 'company-mode))

(custom-set-faces
 '(company-tooltip ((t :background "#403d3d"))) ;; 弹窗背景
 '(company-tooltip-selection ((t :foreground "#f62d6e" :background "#525151"))) ;; 选中选项颜色
 '(company-tooltip-common ((t :foreground "#f62d6e"))) ;; 前缀部分
 '(company-tooltip-common-selection ((t :foreground "#f62d6e"))) ;; 前缀选中部分
 '(company-tooltip-annotation ((t :foreground "#92e56d"))) ;; 注解部分
 '(company-scrollbar-bg ((t :background "#403d3d")))
 '(company-scrollbar-fg ((t :background "#f8f7f1"))))

;; 文档弹出，只在使用桌面系统时使用，使用快捷键 M-h
(when window-system
  (with-eval-after-load 'company
    (require-package 'company-quickhelp)
    (company-quickhelp-mode 1)
    (setq company-quickhelp-delay nil)
    (define-key company-active-map (kbd "M-h") 'company-quickhelp-manual-begin)))

(defun my/completion/push-local-company-backend (backend)
  "添加 buffer local 级别的补全后端 BACKEND."
  (set (make-local-variable 'company-backends)
       (append (list backend) company-backends)))

(provide 'init-completion)
;;; init-completion.el ends here
