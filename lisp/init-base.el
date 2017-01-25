;;; package -- 基础工具和配置
;;; Commentary:
;;; Code:

(fetch-package 'cl-lib)
(fetch-package 'fullframe)
(fetch-package 'diminish)
(fetch-package 'scratch)
(fetch-package 'mwe-log-commands)
(fetch-package 'wgrep)
(fetch-package 'project-local-variables)
(fetch-package 'mmm-mode)
(fetch-package 'guide-key)

(eval-when-compile (require 'cl))
(require 'fullframe)
(require 'diminish)
(require 'scratch)
(require 'mwe-log-commands)
(require 'wgrep)
(require 'project-local-variables)

(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
(guide-key-mode t)
(diminish 'guide-key-mode)

(setq help-window-select t)

(provide 'init-base)
;;;  init-base.el ends here
