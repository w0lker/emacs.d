;;; package -- mmm模式配置，可以让几个主mode共存
;;; Commentary:
;;; Code:

(require-package 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)

(provide 'init-mmm)
;;;  init-mmm.el ends here
