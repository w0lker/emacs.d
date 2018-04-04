;;; package -- YAML 模式
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(config-after-fetch-require 'yaml-mode
  (add-hook 'yaml-mode-hook
            '(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
  )

(provide 'init-yaml)

;; Local Variables:
;; coding: utf-8
;; End:

;;; init-yaml.el ends here
