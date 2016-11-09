;;; package -- Org-mode 配置
;;; Commentary:
;;; Code:

(require-package 'org)

;; 文件关联
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; 储存当前位置的一个链接（全局），精确到行，可以在 org 文件以外的缓冲区使用
(define-key global-map (kbd "C-c l") 'org-store-link)
;; 查看日程
(define-key global-map (kbd "C-c a") 'org-agenda)

(setq org-log-done 'time ;; 启动日志记录类型
      org-hide-emphasis-markers t ;; 隐藏让文本着重显示的标识符，如*hello*显示为 hello 粗体
      org-catch-invisible-edits 'show ;; 防止编辑不可见字符造成的困惑
      org-export-coding-system 'utf-8 ;; 导出为 UTF-8
      org-html-validation-link nil ;; 导出 html 格式时不显示验证信息
      )

(provide 'init-org)
;;;  init-org.el ends here
