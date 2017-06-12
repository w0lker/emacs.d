;;; package -- Evil 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'evil
  (evil-mode t)
  (setq evil-default-state 'normal
	evil-default-cursor '("#98f5ff" box)
	evil-normal-state-cursor '("#98f5ff" box)
	evil-insert-state-cursor '("#98f5ff" (bar . 2))
	evil-visual-state-cursor '("#98f5ff" box)
	evil-replace-state-cursor '("#cd5c5c" box)
	evil-operator-state-cursor '("#98f5ff" box)
	evil-motion-state-cursor '("#98f5ff" box)
	evil-emacs-state-cursor '("#adfa2f" (bar . 2))
	)
  )

(provide 'init-evil)
;;;  init-evil.el ends here
