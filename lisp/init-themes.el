;;; package -- theme config
;;; Commentary:
;;; Code:


(require-package 'molokai-theme)
;; If you don't customize it, this is the theme you get.
(setq-default custom-enabled-themes '(molokai))

;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(add-hook 'after-init-hook 'reapply-themes)

(load-theme '(molokai))

;; Beautiful mode-line
(require-package 'smart-mode-line)
(setq sml/shorten-directory t)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'dark)
(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^:Git:\(.*\)/src/main/java/" ":G/\1/SMJ:") t)


(provide 'init-themes)
;;;  init-themes.el ends here
