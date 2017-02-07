;;; package -- Java 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'eclim
  (config-after-require 'eclimd
    (setq eclimd-autostart t)
    )
  (global-eclim-mode)

  (config-add-hook 'eclim-mode-hook
    (setq help-at-pt-display-when-idle t)
    (setq help-at-pt-timer-delay 0.1)
    (help-at-pt-set-timer)
    )

  (with-eval-after-load 'company
    (config-after-fetch-require 'company-emacs-eclim
      (setq company-emacs-eclim-ignore-case t)
      (company-emacs-eclim-setup)
      )
    )
  )

(provide 'init-java)
;;;  init-java.el ends here
