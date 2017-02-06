;;; package -- 基本配置
;;; Commentary:
;;; Code:

(defconst *startup-benchmark* nil "是否启动性能评估.")

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
    (error (message "Fetch package `%s': %S" package-name err) nil)))

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

(defmacro config-add-hook (hook &rest body)
  "配置 HOOK 的执行代码 BODY 内容会被封装到一个 lambda 表达式中."
  (declare (indent 1) (debug t))
  `(add-hook ,hook (lambda () ,@body))
  )

(defmacro config-bind-global-key (key &rest body)
  "配置绑定 KEY 的执行代码 BODY 内容会被封装到一个 lambda 表达式中."
  (declare (indent 1) (debug t))
  `(if (commandp (lambda (arg) ,@body))
       (global-set-key ,key (lambda (arg) ,@body))
     (global-set-key ,key (lambda () (interactive) ,@body))
     )
  )

(setq use-file-dialog nil
      use-dialog-box nil
      inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      custom-file (concat user-temp-dir "custom.el") ;; 个性化配置文件目录
      auto-save-list-file-prefix (concat user-temp-dir (file-name-as-directory "auto-save-list") "saves-")
      )

(config-after-fetch-require 'cl-lib
  (eval-when-compile (require 'cl))
  )

(config-after-fetch-require 'guide-key
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (guide-key-mode t)
  (config-after-fetch-require 'diminish
    (diminish 'guide-key-mode))
  )

(if (file-exists-p custom-file)
    ;; 载入 custom 文件
    (load custom-file)
  )

(provide 'init-core)
;;;  init-core.el ends here
