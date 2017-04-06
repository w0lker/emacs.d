;;; package -- Evil 配置
;;; Commentary:
;;; Code:

(when (not window-system)
    (config-after-fetch-require 'evil
      (evil-mode t)
      (setq evil-default-state 'normal)

      (config-after-fetch-require 'evil-leader
	(setq-default evil-leader/leader "\\"
		      evil-leader/in-all-states t
		      )
	(evil-leader/set-key "q" 'kill-buffer)
	(evil-leader/set-key "w" 'save-buffer)
	(evil-leader/set-key "l" 'linum-mode)
	(global-evil-leader-mode t)
	)

      (config-after-fetch-require 'evil-surround
	(global-evil-surround-mode t)
	)
      )
  )

(provide 'init-evil)
;;;  init-evil.el ends here
