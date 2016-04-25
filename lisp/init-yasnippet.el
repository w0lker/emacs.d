;; yasnippet配置
(require-package 'yasnippet)
(require 'yasnippet)
(require-package 'dropdown-list)
(require 'dropdown-list)
(add-to-list 'load-path (expand-file-name "snippets" user-emacs-directory))
(yas-global-mode 1)
(setq yas-prompt-functions '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))

(provide 'init-yasnippet)
