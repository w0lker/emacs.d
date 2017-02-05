;;; package -- 基础工具和配置
;;; Commentary:
;;; Code:

(defconst *is-frame* (memq window-system '(mac ns x)) "是否为桌面程序.")
(defconst *startup-benchmark* nil "是否启动性能评估.")
(defconst auto-save-list-file-prefix (concat user-temp-dir (file-name-as-directory "auto-save-list") "saves-") "自动保存文件前缀.")
(defconst custom-file (concat user-temp-dir "custom.el") "个性化配置文件名称文件.")

(defconst before/initial-gc-cons-threshold gc-cons-threshold "启动时初始化 `gc-cons-threshold'.")
(setq gc-cons-threshold (* 256 1024 1024))
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold before/initial-gc-cons-threshold)))

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

(config-after-fetch-require 'cl-lib
  (eval-when-compile (require 'cl)))

(config-after-fetch-require 'guide-key
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (guide-key-mode t)

  (config-after-fetch-require 'diminish
    (diminish 'guide-key-mode))
  )

;; 不显示菜单
(if (and (functionp 'menu-bar-mode)
	 (unless window-system))
    (menu-bar-mode -1))

;; 不显示工具栏
(if (functionp 'tool-bar-mode)
    (tool-bar-mode -1))

;; 不显示滚动条
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;; 无边框
(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

(setq use-file-dialog nil
      use-dialog-box nil
      inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil ;; scratch默认不显示任何内容
      jit-lock-defer-time 0.05 ;; 优化翻页速度
      visible-bell t ;; 关闭出错蜂鸣声
      ring-bell-function 'ignore
      blink-cursor-interval 0.8 ;; 光标闪动频率
      truncate-lines nil ;; 取消不管多少个空行只显示一行
      truncate-partial-width-windows nil
      show-trailing-whitespace t ;; 默认不显示空格信息
      indent-tabs-mode nil ;; 使用空格代替 TAB 键
      tab-width 4
      delete-selection-mode t ;; 可以像普通编辑器一样用delete删除
      kill-whole-line t ;; 同时删除末尾换行符
      save-interprogram-paste-before-kill nil ;; 自动将其它程序加入系统剪切板的内容加入 kill-ring
      select-enable-primary nil ;; primary section中内容不放入系统剪切版
      select-active-regions nil ;; 不把当前选中的选区中的内容放入primary section
      select-enable-clipboard t ;; 剪切复制使用系统剪切板
      set-mark-command-repeat-pop t ;; 打标记时，每次 C-SPC 算不同的标记记录
      help-window-select t
      )

(setq-default indicate-empty-lines nil
	      indicate-buffer-boundaries '((up . left) (down . left))
	      )

(config-after-fetch-require 'molokai-theme
  (load-theme 'molokai t)
  )

(config-after-fetch-require 'smart-mode-line
  (setq sml/no-confirm-load-theme t)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t)
  (setq sml/vc-mode-show-backend nil)

  (custom-set-faces
   '(sml/modes ((t :foreground "#202000")))
   '(sml/prefix ((t :foreground "#d83b5d")))
   '(sml/folder ((t :foreground "#99cc66")))
   '(sml/filename ((t :foreground "#99cc66")))
   '(sml/process ((t :foreground "#99cc66")))
   '(sml/vc ((t :foreground "#203c04")))
   '(sml/vc-edited ((t :foreground "#92e56d")))
   '(sml/minor-modes ((t :foreground "#99cc66"))))

  (if window-system
      (config-after-fetch-require 'smart-mode-line-powerline-theme
	(setq sml/theme 'powerline))
    (setq sml/theme 'dark))

  (sml/setup)
  )

(provide 'init-before)
;;;  init-before.el ends here
