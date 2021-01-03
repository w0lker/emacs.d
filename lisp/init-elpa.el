(require 'package)
(require 'cl-lib)


;; Work-around for https://debbugs.gnu.org/cgi/bugreport.cgi?bug=34341
(when (and (version< emacs-version "26.3") (boundp 'libgnutls-version) (>= libgnutls-version 30604))
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))


(setq package-enable-at-startup nil
      package-user-dir (concat user-temp-dir "elpa")
      package-archives '(("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
             ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
             ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)


(defun fetch-package (package-name)
  "下载指定 PACKAGE-NAME 包."
  (condition-case err
      (if (package-installed-p package-name)
      t
    (progn
      (unless (assoc package-name package-archive-contents)
        (package-refresh-contents))
      (package-install package-name))
    )
    (error (message "下载包 `%s' 错误: %S" package-name err) nil)))

(defun try-require (feature)
  "尝试载入 FEATURE 如果成功则返回 t 否则返回 nil."
  (condition-case err
      (progn
    (if (stringp feature)
            (load-library feature)
          (require feature))
    t
    )
    (error (message "require `%s': %S" feature err) nil)
    )
  )

(defmacro config-after-require (name &rest body)
  "加载 NAME 后执行配置 BODY 的内容."
  (declare (indent 1) (debug t))
  `(if (try-require ,name)
       (with-eval-after-load ,name
    ,@body)
     )
  )

(defmacro config-after-fetch-require (name &rest body)
  "下载并且加载 NAME 包后执行配置 BODY 的内容."
  (declare (indent 1) (debug t))
  `(let ((cost-ts (current-time)))
     (if (fetch-package ,name)
    (config-after-require ,name ,@body)
       )
     (if *startup-benchmark*
    (message "配置: %s 耗时: %.2fs" ,name (float-time (time-since cost-ts)))
       )
     )
  )


(provide 'init-elpa)
;;; iit-elpa.el ends here
