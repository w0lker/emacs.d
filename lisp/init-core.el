;;; package -- 基本配置
;;; Commentary:
;;; Code:

(defconst *startup-benchmark* nil "是否启动性能评估.")

(setq use-file-dialog nil
      use-dialog-box nil
      inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      custom-file (concat user-temp-dir "custom.el") ;; 个性化配置文件目录
      auto-save-list-file-prefix (concat user-temp-dir (file-name-as-directory "auto-save-list") "saves-")
      )

;; 不显示菜单
(menu-bar-mode -1)
;; 不显示工具栏
(tool-bar-mode -1)
;; 不显示滚动条
(scroll-bar-mode -1)

(config-after-fetch-require 'cl-lib
  (eval-when-compile (require 'cl))
  )

(config-after-fetch-require 'mmm-mode
  (setq mmm-global-mode 'buffers-with-submode-classes)
  (setq mmm-submode-decoration-level 2)
  )

(config-after-fetch-require 'guide-key
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (guide-key-mode t)
  (config-after-fetch-require 'diminish
    (diminish 'guide-key-mode))
  )

(provide 'init-core)
;;;  init-core.el ends here
