(require-package 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)

;; 配置cpplint路径
(custom-set-variables
  '(flycheck-c/c++-googlelint-executable "/usr/local/bin/cpplint"))

;; 覆盖默认的触发
(setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
      flycheck-idle-change-delay 0.8)

;; 配置google-cpplint
(require-package 'flycheck-google-cpplint)
(require 'flycheck-google-cpplint)

;; google代码样式
(require-package 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)



(provide 'init-flycheck)
