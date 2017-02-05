;;; package -- Org-mode 配置
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(config-after-require 'org
  ;; 启动日志记录类型
  (setq org-log-done 'time)
  ;; 隐藏让文本着重显示的标识符，如 *hello* 显示为 hello 粗体
  (setq org-hide-emphasis-markers t)
  ;; 防止编辑不可见字符造成的困惑
  (setq org-catch-invisible-edits 'show)
  ;; 导出为 UTF-8
  (setq org-export-coding-system 'utf-8)
  ;; 导出 html 格式时不显示验证信息
  (setq org-html-validation-link nil)

  ;; 解决与 yasnippet <TAB> 键冲突
  (defun org/yas-very-safe-expand ()
    "安全扩展 yasnippet."
    (let ((yas-fallback-behavior nil)) (yas/expand)))

  (defun org/yas-fix-tab-conflict ()
    "解决 yas 和 org 的冲突."
    (make-variable-buffer-local 'yas/trigger-key)
    (setq yas/trigger-key [tab])
    (add-to-list 'org-tab-first-hook 'org/yas-very-safe-expand)
    (define-key yas/keymap [tab] 'yas/next-field))
  (add-hook 'org-mode-hook 'org/yas-fix-tab-conflict)

  (defun org/add-yasnippet-to-company ()
    "添加 yasnippet 补全到 company."
    (completion/push-local-company-backend 'company-yasnippet))
  (add-hook 'org-mode-hook 'org/add-yasnippet-to-company)

  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c b") 'org-iswitchb)

  (with-eval-after-load 'ido
    (setq-default org-completion-use-ido t))
  )

(provide 'init-org)
;;;  init-org.el ends here
