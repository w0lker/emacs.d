(require-package 'auto-complete)
;; 解决include ""之间不自动提示问题
(setq ac-disable-faces nil)
(setq ac-ignore-case nil)

(ac-config-default)

;; 配置补全显示颜色
(set-face-background 'ac-candidate-face "white")
(set-face-background 'ac-selection-face "brightblack")
(set-face-background 'popup-summary-face "white")
(set-face-background 'popup-tip-face "brightblack")


;; C语言header配置
(require-package 'auto-complete-c-headers)
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/local/include/c++/5.3.0")
 )
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; yasnippet配置
(require-package 'yasnippet)
(require-package 'dropdown-list)
(add-to-list 'load-path "~/.emacs.d/snippets")
(yas-global-mode 1)
(setq yas-prompt-functions '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))

(provide 'init-auto-complete)
