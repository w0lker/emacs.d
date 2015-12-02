(require-package 'auto-complete)
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(require-package 'auto-complete-c-headers)
(defun my:ac-c-header-init ()
    (require 'auto-complete-c-headers)
    (add-to-list 'ac-sources 'ac-source-c-header)
    (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include"))
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; clang补全实现
(require-package 'auto-complete-clang-async)
(require 'auto-complete-clang-async)
(defun ac-cc-mode-setup ()
      ;; you should change the server program's path here
      (setq ac-clang-complete-executable "/usr/local/opt/emacs-clang-complete-async/bin/clang-complete")
      (setq ac-sources (append '(ac-source-clang-async) ac-sources))
      (ac-clang-launch-completion-process))
(defun my-ac-config ()
    (add-hook 'c++-mode-hook 'ac-cc-mode-setup)
    (add-hook 'c-mode-hook 'ac-cc-mode-setup)
    (global-auto-complete-mode t))
(my-ac-config)

(provide 'init-auto-complete)
