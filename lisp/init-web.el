;;; package -- Web 编辑
;;; Commentary:
;;; Code:

(use-package emmet-mode
  :ensure t
  :commands emmet-mode
  :init
  (setq emmet-indentation 2)
  (use-package web-mode
    :ensure t
    :mode (("\\.phtml\\'" . web-mode)
	   ("\\.tpl\\.php\\'" . web-mode)
	   ("\\.[agj]sp\\'" . web-mode)
	   ("\\.as[cp]x\\'" . web-mode)
	   ("\\.erb\\'" . web-mode)
	   ("\\.mustache\\'" . web-mode)
	   ("\\.djhtml\\'" . web-mode)
	   ("\\.html?\\'" . web-mode))
    :init
    (setq web-mode-enable-current-column-highlight t)
    )
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  )


(provide 'init-web)
;;;  init-web.el ends here
