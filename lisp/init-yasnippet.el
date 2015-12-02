(require-package 'yasnippet)

(add-to-list 'load-path "~/.emacs.d/snippets")
(require 'yasnippet)
(yas-global-mode 1)

(require-package 'dropdown-list)
(require 'dropdown-list)
(setq yas-prompt-functions '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))


(provide 'init-yasnippet)
