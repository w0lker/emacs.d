;;;-----------------------------------------------------------------------
;;; 代码检查
;;;-----------------------------------------------------------------------
(when (load "flymake" t)
  (defun my/flymake-google-cpplint-init ()

    ;; google风格检查
    (when (maybe-require-package 'flymake-google-cpplint)
      ;; 让错误信息显示在minibuffer
      (maybe-require-package 'flymake-cursor)
      (maybe-require-package 'flymake-easy)
      (custom-set-variables
       '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
       '(flymake-google-cpplint-verbose "--verbose=0")
       ;; 有一个bug,如果不加verbose的配置，这个过滤的配置也不能生效
       '(flymake-google-cpplint-filter "--filter=-build/include")
       )
      (add-hook 'c-mode-common-hook 'flymake-google-cpplint-load)
      )
    )
  (my/flymake-google-cpplint-init)
  )

;; google代码风格
(when (maybe-require-package 'google-c-style)
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  )

;;;-----------------------------------------------------------------------
;;; 自动补全
;;;-----------------------------------------------------------------------
(when (require-package 'auto-complete)
  (require 'auto-complete)
  (require 'auto-complete-config)
  (ac-config-default)
  ;; 如果不包含大写则忽略大小写
  (setq ac-ignore-case 'smart)

  ;; 配置补全显示颜色
  (set-face-background 'ac-candidate-face "white")
  (set-face-background 'ac-selection-face "brightblack")
  (set-face-background 'popup-summary-face "white")
  (set-face-background 'popup-tip-face "brightblack")

  ;; 头文件补全配置
  (when (require-package 'auto-complete-c-headers)
    (defun my/ac-c-headers-init ()
      (require 'auto-complete-c-headers)
      (setq ac-disable-faces nil) ;; 解决include ""之间不自动提示问题
      (add-to-list 'ac-sources 'ac-source-c-headers)
      (add-to-list 'achead:include-directories '"/usr/local/include/c++/5.3.0")
      )
    (add-hook 'c-mode-common-hook 'my/ac-c-headers-init))

  ;; 配置cedet
  (when (require-package 'cedet)
    (semantic-mode 1)
    (defun my/add-semantic-to-ac ()
      ;; 将语法分析的结果加入autocomplete的源当中
      (add-to-list 'ac-sources 'ac-source-semantic)
      (global-semantic-decoration-mode 1)
      (global-semantic-idle-scheduler-mode 2)

      ;; 配置ede
      (global-ede-mode t)
      (ede-cpp-root-project "my_project"
                            :file "~/Works/so-index-slave/src/main.cc"
                            :include-path '("/../my_inc")
                            )
      ;; 设置定位到代码的定义位置的快捷键
      (local-set-key (kbd "C-c r") 'semantic-ia-fast-jump))
    (add-hook 'c-mode-common-hook 'my/add-semantic-to-ac))

  )

;; 配置在源码和头文件之间切换，如果文件不存在可以自动创建
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-related-file)
            ))

;; 编译工具
(require-package 'cmake-mode)

(provide 'init-cpp)
