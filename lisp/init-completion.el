;;; package -- 代码补全
;;; Commentary:
;;; Code:

(with-eval-after-load 'abbrev (diminish 'abbrev-mode))

;; 配置已经出现过符号的补全
(setq hippie-expand-try-functions-list '(try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill))
(global-set-key (kbd "M-/") 'hippie-expand)

(use-package company
  :ensure t
  :demand t
  :diminish company-mode
  :bind (:map company-mode-map
	      ("M-/" . company-complete)
	      ("M-/" . company-select-next))
  :init
  ;; 配置 TAB 先用来缩进，如果已经缩进则用来补全
  (setq tab-always-indent 'complete)
  ;; 配置补全候选结果数量
  (setq completion-cycle-threshold 5)
  ;; 补全样式
  ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html
  ;; 使用这个样式可以补全首字母缩写，如:使用 lch 补全 list-command-history
  (add-to-list 'completion-styles 'initials t)
  (custom-set-faces
   '(company-tooltip ((t :background "#403d3d"))) ;; 弹窗背景
   '(company-tooltip-selection ((t :foreground "#f62d6e" :background "#525151"))) ;; 选中选项颜色
   '(company-tooltip-common ((t :foreground "#f62d6e"))) ;; 前缀部分
   '(company-tooltip-common-selection ((t :foreground "#f62d6e"))) ;; 前缀选中部分
   '(company-tooltip-annotation ((t :foreground "#92e56d"))) ;; 注解部分
   '(company-scrollbar-bg ((t :background "#403d3d")))
   '(company-scrollbar-fg ((t :background "#f8f7f1"))))
  (setq company-idle-delay .5)
  (setq company-minimum-prefix-length 2)
  (setq company-backends '(company-nxml
			   company-css
			   company-cmake
			   company-clang
			   company-capf ;; completion-at-point-functions
			   company-files
			   (company-dabbrev-code company-gtags company-keywords)
			   company-dabbrev))
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (use-package company-quickhelp
    :ensure t
    :if window-system
    :bind (:map company-active-map
		("M-h" . company-quickhelp-manual-begin))
    :init
    (setq company-quickhelp-delay nil) ;; 不自动弹出
    :config
    (company-quickhelp-mode 1))

  (defun completion/push-local-company-backend (backend)
    "添加 buffer local 级别的补全后端 BACKEND."
    (setq-local company-backends (append (list backend) company-backends)))
  )

;; 设置个性化 snippets 目录
(defconst completion/yas-snippet-dirs (expand-file-name ".snippets" user-emacs-directory))
(use-package yasnippet
  :ensure t
  :demand t
  :diminish yas-minor-mode
  :load-path completion/yas-snippet-dirs
  :init
  (use-package dropdown-list :ensure t)
  (setq yas-prompt-functions '(yas-dropdown-prompt
			       yas-ido-prompt
			       yas-completing-prompt))
  (defconst yas-snippet-dirs completion/yas-snippet-dirs)
  :config
  (yas-global-mode t))

(provide 'init-completion)
;;; init-completion.el ends here
