(require-package 'auto-complete)
;; 解决include ""之间不自动提示问题
(setq ac-disable-faces nil) 
(ac-config-default)

;; header配置
(require-package 'auto-complete-c-headers)
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/local/include/c++/5.2.0")
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
