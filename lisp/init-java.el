;;; package -- Java 配置
;;; Commentary:
;;; Code:

(require-package 'jdee)
(require 'jdee)

(setq jdee-server-dir (concat user-emacs-directory
			      (file-name-as-directory my-temp-dir)
			      "jdee"))

(provide 'init-java)
;;;  init-java.el ends here
