;;; package -- yasnippet配置
;;; Commentary:
;;; Code:

(require-package 'yasnippet)
(require-package 'dropdown-list)
(add-to-list 'load-path (expand-file-name "snippets" user-emacs-directory))

(yas-global-mode 1)
(setq yas-prompt-functions '(yas-dropdown-prompt yas-ido-prompt yas-completing-prompt))

(diminish 'yas-minor-mode)

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
