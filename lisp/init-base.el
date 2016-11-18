;;; package -- 基础工具和配置
;;; Commentary:
;;; Code:

;; 启动后临时减小垃圾收集时间
(defconst my/base/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold my/base/initial-gc-cons-threshold)))

(defun require-package (package &optional min-version no-refresh)
  "自动下载指定包 PACKAGE，如果失败返回nil并且打印错误信息.
可选参数:
MIN-VERSION 指定最小版本，
NO-REFRESH 如果为非nil是则不下载指定库而使用本地的."
  (condition-case err
      (if (package-installed-p package min-version)
          t
        (if (or (assoc package package-archive-contents) no-refresh)
            (if (boundp 'package-selected-packages)
                ;; Record this as a package the user installed explicitly
                (package-install package nil)
              (package-install package))
          (progn
            (package-refresh-contents)
            (require-package package min-version t))))
    (error
     (message "Couldn't install package `%s': %S" package err)
     nil)))

;; Common-Lisp扩展库
(require-package 'cl-lib)
(require 'cl-lib)
(eval-when-compile (require 'cl))

;; 必需的包
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)
(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'fullframe)

;; 让主模式共存
(require-package 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)

;; 快捷键提示
(when (require-package 'guide-key)
  (require 'guide-key)
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (guide-key-mode 1)
  (with-eval-after-load 'guide-key
    (diminish 'guide-key-mode)))

;; 全屏显示包列表
(fullframe list-packages quit-window)

(provide 'init-base)
;;;  init-base.el ends here
