;;; package -- 自定义宏初始化
;;; Commentary:
;;; Code:

(defconst *startup-benchmark* nil "是否启动性能评估.")

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

(defmacro config-bind-map-key (map key &rest body)
  "配置绑定 MAP 到按键 KEY 执行代码 BODY 内容会被封装到一个 lambda 表达式中."
  (declare (indent 1) (debug t))
  `(if ,map
       (if (commandp (lambda (arg) ,@body))
       (define-key ,map ,key (lambda (arg) ,@body))
     (define-key ,map ,key (lambda () (interactive) ,@body))
     )
     (message "绑定键为: nil")
     )
  )

(defmacro command-run (basedir command &rest args)
  "运行指定 BASEDIR 的 COMMAND 及参数 ARGS, 如果BASEPATH为空或者nil则使用默认访问路径."
  `(let* ((basedir-arg ,basedir)
      (command-arg ,command)
      (command-full-path (if (and basedir-arg (not (string= basedir-arg "")))
                 (concat (file-name-as-directory basedir-arg) command-arg)
               command-arg
                   ))
      )
     (start-process (format "command:%s" command-full-path)
            (format "*command:%s*" command-arg)
            command-full-path
            ,@args)
     )
  )

(provide 'init-macro)
;;;  init-macro.el ends here
