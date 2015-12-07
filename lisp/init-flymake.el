(require-package 'flymake-google-cpplint)
;; 让错误信息显示在minibuffer
(require-package 'flymake-cursor)
(require-package 'flymake-easy)

;; google风格检查
(require 'flymake-google-cpplint)
(custom-set-variables
 '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
 '(flymake-google-cpplint-verbose "--verbose=0")
 ;; 有一个bug,如果不加verbose的配置，这个过滤的配置也不能生效
 '(flymake-google-cpplint-filter "--filter=-build/include") 
 )
(add-hook 'c-mode-common-hook 'flymake-google-cpplint-load)

;; google代码风格
(require-package 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(provide 'init-flymake)
