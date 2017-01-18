;;; package -- Vagrant 配置
;;; Commentary:
;;; Code:

(use-package vagrant
  :ensure t
  :config
  (use-package vagrant-tramp :ensure t)
  )

(provide 'init-vagrant)
;;;  init-vagrant.el ends here
