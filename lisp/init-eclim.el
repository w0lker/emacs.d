;;; package -- eclim配置
;;; Commentary:
;;; Code:


(require-package 'emacs-eclim)
(require 'eclim)

(custom-set-variables
  '(eclim-eclipse-dirs '("/Applications/Eclipse.app/Contents/Eclipse"))
  '(eclim-executable "/Applications/Eclipse.app/Contents/Eclipse/eclim"))

(global-eclim-mode)

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)
(setq company-emacs-eclim-ignore-case t)

(require 'eclimd)
(custom-set-variables
 '(eclimd-default-workspace "~/Works/eclipse/bigdata") ;; 设置默认workspace
 '(eclimd-wait-for-process nil) ;; 设置启动eclimd后不等待
 )


(provide 'init-eclim)
;;;  init-eclim.el ends here
