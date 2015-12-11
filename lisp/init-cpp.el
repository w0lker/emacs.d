;; 代码检查
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

;; 自动补全
(require-package 'auto-complete)
;; 解决include ""之间不自动提示问题
(setq ac-disable-faces nil)
(ac-config-default)

;; 配置补全显示颜色
(set-face-background 'ac-candidate-face "white")
(set-face-background 'ac-selection-face "brightblack")
(set-face-background 'popup-summary-face "white")
(set-face-background 'popup-tip-face "brightblack")

;; header配置
(require-package 'auto-complete-c-headers)
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/local/include/c++/5.3.0")
 )
(add-hook 'c-mode-common-hook 'my:ac-c-header-init)

;; 语法分析，可以将当前类目录的头文件中的symbol解析出来
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;; ede-mode 添加要分析的project信息
(global-ede-mode t)
(ede-cpp-root-project "my project"
                      :file "~/Works/so-index-slave/src/main.cc"
                      :include-path '("/../include"))

;; 设置代码分析的时间
(global-semantic-idle-scheduler-mode 2)
(global-set-key (kbd "C-c j") 'semantic-ia-fast-jump)

;; 配置在源码和头文件之间切换，如果文件不存在可以自动创建
(add-hook 'c-mode-common-hook
          (lambda()
                (local-set-key  (kbd "C-c o") 'ff-find-related-file)))

;; 编译工具
(require-package 'cmake-mode)
(require 'cmake-mode)

(provide 'init-cpp)
