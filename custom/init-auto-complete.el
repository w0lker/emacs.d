(require-package 'auto-complete)
(ac-config-default)

;; header配置
(require-package 'auto-complete-c-headers)
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/7.0.0/include"))

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; yasnippet配置
(require-package 'yasnippet)
(require-package 'dropdown-list)
(add-to-list 'load-path "~/.emacs.d/snippets")
(yas-global-mode 1)
(setq yas-prompt-functions '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))

;; 补全
(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))

(provide 'init-auto-complete)
