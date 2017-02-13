;;; package -- Java 配置
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))

(config-add-hook 'java-mode-hook
  (config-after-fetch-require 'eclim
    (setq eclimd-autostart nil
	  eclim-executable "~/.local/bin/eclim"
	  )
    (eclim-mode t)
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
