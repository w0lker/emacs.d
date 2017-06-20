;;; package -- 编辑器配置
;;; Commentary:
;;; Code:

(setq use-file-dialog nil
      use-dialog-box nil
      inhibit-startup-screen t ;; 禁止启动屏幕
      inhibit-startup-echo-area-message t ;; 不在scrach中显示信息
      completion-cycle-threshold 5 ;; 补全候选数目
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
      indicate-empty-lines nil ;; 空行显示一个标识
      indicate-buffer-boundaries '((up . left) (down . left))
      )

;; 设置启动选区快捷键
(global-set-key (kbd "C-.") 'set-mark-command)

;; 添加全局补全样式
(add-to-list 'completion-styles 'initials t)

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

;; 成对插入括号
(setq electric-pair-pairs '((?\" . ?\")
			    (?\' . ?\')
			    (?\{ . ?\})
			    )
      )
(electric-pair-mode 1)

;; 高亮匹配的括号
(show-paren-mode 1)

(config-after-require 'autorevert
  ;; 不断监听当前buffer变化，如果其它编辑器同时修改该文件，修改会同步过来
  (global-auto-revert-mode t)
  (setq global-auto-revert-non-file-buffers t
        auto-revert-verbose nil
	)
  (with-eval-after-load 'diminish
    (diminish 'auto-revert-mode)
    )
  )

(config-after-fetch-require 'diff-hl
  ;; 左侧显示提示修改内容
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
  )

(config-after-fetch-require 'highlight-escape-sequences
  ;; 高亮转移部分
  (hes-mode)
  )

(config-after-fetch-require 'smooth-scrolling
  ;; 平滑鼠标滚动
  (smooth-scrolling-mode t)
  )

(config-after-fetch-require 'undo-tree
  ;; 修改记录树
  (global-undo-tree-mode t)
  (with-eval-after-load 'diminish
    (diminish 'undo-tree-mode)
    )
  )

(config-after-fetch-require 'rainbow-delimiters
  ;; 不同层括号颜色不同
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )

(config-after-fetch-require 'highlight-escape-sequences
  ;; 高亮转义字符
  (hes-mode t)
  )

(config-after-fetch-require 'move-dup
  ;; 移动或者复制当前行
  (global-set-key [M-S-up] 'md/move-lines-up)
  (global-set-key [M-S-down] 'md/move-lines-down)
  (global-set-key (kbd "C-c d") 'md/duplicate-down)
  (global-set-key (kbd "C-c D") 'md/duplicate-up)
  )

(config-after-fetch-require 'whole-line-or-region
  ;; 选中一行或者特定的选区
  (whole-line-or-region-mode t)
  (diminish 'whole-line-or-region-mode)
  (make-variable-buffer-local 'whole-line-or-region-mode)

  (defun suspend-mode-during-cua-rect-selection (mode-name)
    (let ((flagvar (intern (format "%s-was-active-before-cua-rectangle" mode-name)))
	  (advice-name (intern (format "suspend-%s" mode-name))))
      (eval-after-load 'cua-rect
	`(progn
	   (defvar ,flagvar nil)
	   (make-variable-buffer-local ',flagvar)
	   (defadvice cua--activate-rectangle (after ,advice-name activate)
	     (setq ,flagvar (and (boundp ',mode-name) ,mode-name))
	     (when ,flagvar
	       (,mode-name 0)))
	   (defadvice cua--deactivate-rectangle (after ,advice-name activate)
	     (when ,flagvar
	       (,mode-name 1)))))))
  (suspend-mode-during-cua-rect-selection 'whole-line-or-region-mode)
  )

(config-bind-global-key [remap backward-up-list]
  ;; 使用快捷键`C-M-u'跳到包围当前表达式、代码块或者字符串的前层括号处
  ;; 解决`backwark-up-list'函数不能识别包围字符串的引号的问题
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (backward-up-sexp (1- arg)))
          ((backward-up-list arg)))
    )
  )

(config-after-fetch-require 'ace-jump-mode
  ;; 便捷跳转
  (setq ace-jump-mode-case-fold nil)
  (global-set-key (kbd "C-;") 'ace-jump-mode)
  )

(config-bind-global-key (kbd "M-j")
  ;; 将下一行结果join到当前行
  (next-line)
  (join-line)
  (delete-horizontal-space)
  )

(config-bind-global-key (kbd "RET")
  ;; 创建新行使用和前面文本同样的缩进
  (newline-and-indent)
  )

(config-bind-global-key (kbd "S-<return>")
  ;; 下方创建一个新行，光标移到行首
  (move-end-of-line 1)
  (newline-and-indent)
  )

(config-bind-global-key (kbd "S-M-<return>")
  ;; 上方创建一个新行，光标移到行首
  (previous-line)
  (move-end-of-line 1)
  (newline-and-indent)
  )

(config-bind-global-key (kbd "C-M-<backspace>")
  ;; 从当前位置删除到行首缩进位置
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos))
  )

(config-bind-global-key (kbd "C-M-\\")
  ;; 选择区域或者全部内容执行缩进
  (save-excursion
    (if (region-active-p)
	(indent-region (region-beginning) (region-end))
      (indent-region (point-min) (point-max))
      )
    )
  )

(config-after-require 'imenu
  (setq imenu-auto-rescan t ;; 设置自动重新索引
	imenu-auto-rescan-maxout 20000
	)

  (defun imenu-rescan ()
    "手动重新索引当前buffer."
    (interactive)
    (imenu--menubar-select imenu--rescan-item)
    )

  (defun imenu-try-index()
    "尝试给支持imenu的主模式都添加imenu."
    (condition-case nil (imenu-add-menubar-index) (error nil))
    )

  (add-hook 'font-lock-mode-hook 'imenu-try-index)

  (config-after-fetch-require 'imenu-anywhere
    (global-set-key (kbd "C-c .") 'imenu-anywhere)
    )
  )

(if (memq window-system '(ns x))
    ;; 获得shell的环境变量
    (config-after-fetch-require 'exec-path-from-shell
      (dolist (var '("TERM" "SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "LC_ALL" "PATH" "PS1"))
	(add-to-list 'exec-path-from-shell-variables var)
	)
      (exec-path-from-shell-initialize)
      )
  )

(provide 'init-editor)
;;;  init-editor.el ends here
