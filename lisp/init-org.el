;;; package -- Org模式配置
;;; Commentary:
;;; Code:

(config-after-require 'org
  (setq org-log-done 'time ;; 启动日志记录类型
        org-catch-invisible-edits 'show ;; 防止编辑不可见字符造成的困惑
        org-export-coding-system 'utf-8 ;; 导出为 UTF-8
        org-html-validation-link nil ;; 导出 html 格式时不显示验证信息
        org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
                                "xelatex -interaction nonstopmode %f") ;; 解决输出中文pdf问题
        )

  ;; 支持markdown
  (config-after-require 'ox-md)

  (with-eval-after-load 'ido
    (setq org-completion-use-ido t)
    )

  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c b") 'org-iswitchb)

  (config-add-hook 'org-mode-hook
    (with-eval-after-load 'yasnippet
      (yas-minor-mode 1)
      (yasnippet/add-buffer-local-company-backend)
      )
    )
  )

(provide 'init-org)
;;;  init-org.el ends here
