;;; package -- IDO 配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'ido
  (setq-default ido-save-directory-list-file (concat user-temp-dir "ido.last")) ;; 保存目录
  (setq ido-enable-flex-matching t ;; 非常开放的匹配方式 aa 可以匹配 alpha
	ido-enable-regexp t ;; 支持正则表达式
	ido-use-filename-at-point nil
	ido-auto-merge-work-directories-length -1
	ido-use-virtual-buffers t
	ido-default-buffer-method 'selected-window ;; 允许一个 buffer 同时在不同的的 frame 中打开
	)

  ;; C-s 下一条
  ;; C-r 上一条
  (ido-mode 1)
  (ido-everywhere 1)

  (config-add-hook 'ido-setup-hook
    (define-key ido-completion-map [up] 'previous-history-element)
    )
  
  (config-after-fetch-require 'smex
    (setq-default smex-save-file (concat user-temp-dir "smex-items"))
    (global-set-key [remap execute-extended-command] 'smex)
    )

  (config-after-fetch-require 'ido-ubiquitous
    (ido-ubiquitous-mode 1))

  (config-after-fetch-require 'ido-yes-or-no
    (ido-yes-or-no-mode 1))

  (config-after-fetch-require 'crm-custom
    (crm-custom-mode 1))

  (config-after-fetch-require 'ido-select-window
    (global-set-key (kbd "C-x o") 'ido-select-window))
  )

(provide 'init-ido)
;;;  init-ido.el ends here
