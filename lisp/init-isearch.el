(defun my/isearch-face-settings ()
  "Face settings for `isearch'."
  (set-face-foreground 'isearch "brightred")
  ;;(set-face-background 'isearch "blue")
  (custom-set-faces '(isearch-fail ((((class color)) (:background "red"))))))

(eval-after-load "isearch"
  `(my/isearch-face-settings))

(provide 'init-isearch)
