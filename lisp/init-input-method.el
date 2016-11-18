;;; package -- 输入法
;;; Commentary:
;;; Code:

(require-package 'chinese-pyim)
(require 'chinese-pyim)

;; 词库
(require-package 'chinese-pyim-greatdict)
(require 'chinese-pyim-greatdict)
(chinese-pyim-greatdict-enable)

;; 启动时加载字典
(add-hook 'emacs-startup-hook
          #'(lambda () (pyim-restart-1 t)))

;; 输入一段拼音然后将他们转换为中文
(global-set-key (kbd "M-j") 'pyim-convert-code-at-point)

;; 设置默认输入法
(setq default-input-method "chinese-pyim")

;; 存储位置
(setq pyim-directory (concat user-emacs-directory
                             (file-name-as-directory my-temp-dir)
                             "pyim"))
(setq pyim-dcache-directory (concat user-emacs-directory
                                    (file-name-as-directory my-temp-dir)
                                    (file-name-as-directory "pyim")
                                    "dcache"))

;; 在mode-line中显示名称
(setq pyim-title "中")
;; 每页显示词条数目
(setq pyim-page-length 6)
;; 选框绘制实现
(setq pyim-page-tooltip nil)
;; 单行选框
(setq pyim-page-style 'one-line)
;; 加快反应速度，减少backends
(setq pyim-backends '(dcache-personal dcache-common pinyin-chars pinyin-shortcode))

;; 英文自动切换
(setq-default pyim-english-input-switch-functions
	      '(pyim-probe-dynamic-english
		pyim-probe-isearch-mode
		pyim-probe-program-mode
		pyim-probe-evil-normal-mode
		evil-visual-state-p
		pyim-probe-org-structure-template))

;; 全角和半角标点自动切换
(setq-default pyim-punctuation-half-width-functions
	      '(pyim-probe-punctuation-line-beginning
		pyim-probe-punctuation-after-punctuation))

(provide 'init-input-method)
;;;  init-input-method.el ends here
