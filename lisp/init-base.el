;;; package -- 常用工具函数和宏
;;; Commentary:
;;; Code:

;; 统一使用y/n
(defalias 'yes-or-no-p 'y-or-n-p)
;; 配置个性化文件名
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; 启动后临时减小垃圾收集时间
(defconst my/base/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold my/base/initial-gc-cons-threshold)))

;; 自动下载指定包
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

;; 自动下载指定包，如果失败返回nil并且打印错误信息
(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install package `%s': %S" package err)
     nil)))

;; common lisp扩展库
(require-package 'cl-lib)
(require 'cl-lib)
(eval-when-compile (require 'cl))

;; 必需的包
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)
(require-package 'wgrep)
(require-package 'project-local-variables)

;; 让主模式共存
(require-package 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)

;; 快捷键提示
(when (maybe-require-package 'guide-key)
  (require 'guide-key)
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (guide-key-mode 1)
  (diminish 'guide-key-mode))

(provide 'init-base)
;;;  init-base.el ends here
