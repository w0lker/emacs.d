;;; package -- Web 编辑
;;; Commentary:
;;; Code:

(fetch-package 'web-mode)
(fetch-package 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" web-mode))

(require 'web-mode)
(setq web-mode-enable-current-column-highlight t)

(require 'emmet-mode)
(setq emmet-indentation 2)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

(provide 'init-web)
;;;  init-web.el ends here
