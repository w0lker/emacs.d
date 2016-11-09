;;; package -- 输入法
;;; Commentary:
;;; Code:

(require-package 'chinese-pyim)
(require 'chinese-pyim)
(require-package 'chinese-pyim-greatdict)
(require 'chinese-pyim-greatdict)
(chinese-pyim-greatdict-enable)

;; 存储位置
(setq pyim-directory (concat user-emacs-directory
                             (file-name-as-directory my-temp-dir)
                             "pyim"))
(setq pyim-dcache-directory (concat user-emacs-directory
                                    (file-name-as-directory my-temp-dir)
                                    (file-name-as-directory "pyim")
                                    "dcache"))
;; 自动切换英文策略
(setq pyim-english-input-switch-functions
      '(pyim-probe-dynamic-english
        pyim-probe-isearch-mode
        pyim-probe-program-mode
        pyim-probe-org-structure-template))
;; 自动切换全角和半角标点输入
(setq pyim-punctuation-half-width-functions
      '(pyim-probe-punctuation-line-beginning
        pyim-probe-punctuation-after-punctuation))
;; 每页显示词条数目
(setq pyim-page-length 6)
;; 选框绘制实现
(setq pyim-page-tooltip nil)
;; 单行选框
(setq pyim-page-style 'one-line)
;; 在mode-line中显示名称
(setq pyim-title "中")
;; 加快反应速度，减少backends
(setq pyim-backends '(dcache-personal dcache-common pinyin-chars))

(global-set-key (kbd "M-j") 'pyim-convert-code-at-point)
                                     
;; 启动时加载字典
(add-hook 'emacs-startup-hook
          #'(lambda () (pyim-restart-1 nil nil)))

(provide 'init-input-method)
;;;  init-input-method.el ends here
