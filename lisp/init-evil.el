;;; package -- Evil 配置
;;; Commentary:
;;; Code:

(when (not window-system)
  (config-after-fetch-require 'evil
    (evil-mode t)
    (setq evil-default-state 'normal)
    )
  )

(provide 'init-evil)
;;;  init-evil.el ends here
