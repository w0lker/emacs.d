;;; package -- Tex 配置
;;; Commentary:
;;; Code:

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(with-eval-after-load 'company
  (config-after-fetch-require 'company-auctex
    (company-auctex-init))
  )

(provide 'init-tex)
;;;  init-tex.el ends here
