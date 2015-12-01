(require 'package)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(add-to-list 'package-archives `("melpa" . ,(if (< emacs-major-version 24)
						"http://melpa.org/packages/"
					      "https://melpa.org/packages/")))
(package-initialize)

(provide 'init-elpa)
