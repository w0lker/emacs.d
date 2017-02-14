;;; package -- Org 配置
;;; Commentary:
;;; Code:

(config-after-require 'org
  (setq org-log-done 'time ;; 启动日志记录类型
	org-hide-emphasis-markers t ;; 隐藏让文本着重显示的标识符，如 *hello* 显示为 hello 粗体
	org-catch-invisible-edits 'show ;; 防止编辑不可见字符造成的困惑
	org-export-coding-system 'utf-8 ;; 导出为 UTF-8
	org-html-validation-link nil ;; 导出 html 格式时不显示验证信息
	)

  (with-eval-after-load 'ido
    (setq org-completion-use-ido t)
    )

  (with-eval-after-load 'evil
    (config-after-fetch-require 'evil-org)
    )
  
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c b") 'org-iswitchb)

  (config-add-hook 'org-mode-hook
    (with-eval-after-load 'yasnippet
      (with-eval-after-load 'company
	;; 添加 yasnippet 补全到 company.
	(company/push-local-backend 'company-yasnippet)
	)
      )
    )
  )

(provide 'init-org)
;;;  init-org.el ends here
