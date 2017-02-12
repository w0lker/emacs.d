;;; package -- Java 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'eclim
  (add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
  (setq eclimd-autostart t
	eclimd-default-workspace "~/Default"
	)

  (config-add-hook 'java-mode-hook
    (eclim-mode t)
    )

  (config-add-hook 'eclim-mode-hook
    (with-eval-after-load 'company
      (config-after-fetch-require 'company-emacs-eclim
	(setq company-emacs-eclim-ignore-case t)
	(company-emacs-eclim-setup)
	)
      )
    )
  )

(provide 'init-java)
;;;  init-java.el ends here
