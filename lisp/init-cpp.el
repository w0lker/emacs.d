;;; package -- c++-mode配置文件
;;; Commentary:
;;; Code:


;; 指定头文件使用c++－mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; 设置evil-leader
(evil-leader/set-key-for-mode 'c++-mode
  "j" 'semantic-ia-fast-jump ;; 跳到代码的定义处
  "t" 'ff-find-related-file ;; 在头文件和源码之间切换
  )

(defun my/google-style-check-init ()
  "配置google风格代码检查."
  (when (load "flymake" t)
    (when (maybe-require-package 'flymake-google-cpplint)
      (custom-set-variables
       '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
       '(flymake-google-cpplint-verbose "--verbose=0")
       ;; 有一个bug,如果不加verbose的配置，这个过滤的配置也不能生效
       '(flymake-google-cpplint-filter "--filter=-build/include")
       )
      (add-hook 'c-mode-common-hook 'flymake-google-cpplint-load)
      )
    )
  )

(add-hook 'c-mode-common-hook 'my/google-style-check-init)


;; 代码自动格式化为google风格
(when (maybe-require-package 'google-c-style)
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  )


(defun my/ac-c-headers-init ()
  "初始化头文件auto-complete配置."
  (when (maybe-require-package 'auto-complete-c-headers)
    (require 'auto-complete-c-headers)
    (setq ac-disable-faces nil) ;; 解决include ""之间不自动提示问题
    (add-to-list 'ac-sources 'ac-source-c-headers)
    (add-to-list 'achead:include-directories '"/usr/local/include/c++/5.3.0")
    )
  )

(add-hook 'c-mode-common-hook 'my/ac-c-headers-init)


;; 配置cedet

;; 通过EDE添加头文件信息到auto-complete-c-headers
(add-hook 'ede-minor-mode-hook (lambda ()
                                   (setq achead:get-include-directories-function 'ede-object-system-include-path)))

;; 配置在源码和头文件之间切换，如果文件不存在可以自动创建
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-related-file)
            ))


(provide 'init-cpp)
;;;  init-cpp.el ends here
