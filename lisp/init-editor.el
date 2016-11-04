;;; package -- 编辑器
;;; Commentary:
;;; Code:

;; 基本配置
(setq-default
 major-mode 'text-mode ;; 默认模式不使用fundamental-mode
 jit-lock-defer-time 0.05 ;; 优化翻页速度
 blink-cursor-interval 0.5 ;; 光标闪动频率
 case-fold-search t ;; 搜索时大小写不敏感,nil表示敏感
 column-number-mode t ;; mode-line上显示列数
 delete-selection-mode t ;; 可以像普通编辑器一样用delete删除
 ediff-split-window-function 'split-window-horzontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil ;; 使用空格代替tab进行缩进
 tab-width 4 ;;使用4个空格代替
 make-backup-files nil ;; 有版本控制系统，无必要
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay .5
 show-trailing-whitespace nil ;; 默认不显示空格信息
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t ;; 关闭出错蜂鸣声
 ring-bell-function 'ignore
 auto-save-list-file-prefix (concat user-emacs-directory
                                    (file-name-as-directory my-temp-dir)
                                    (file-name-as-directory "auto-save-list")
                                    "saves-") ;; 自动保存
 )

;; 关闭narrowing功能，使用narrowing功能，可以在buffer中只显示选中的区域的内容，其它部分隐藏，比较容易造成困惑
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; 不断监听当前buffer的变化，如果其它编辑器同时修改该文件，修改会同步过来
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;; 配置undo树
(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

;; 设置redo
(require-package 'redo+)
(global-set-key (kbd "C-?") 'redo)
(setq undo-no-redo t)

;; 成对插入符号
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))

;; 括号自动缩进
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

;; 高亮匹配的括号
(show-paren-mode 1)

;; 让不同级别的括号显示不同颜色
(when (require-package 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; 对于对齐结果显示一根对齐竖线(有一个问题就是文件大的话会比较慢，如果程序打开大文件比较慢可以考虑关闭)
(when (require-package 'indent-guide)
  (add-hook 'prog-mode-hook 'indent-guide-mode)
  (with-eval-after-load 'indent-guide
    (diminish 'indent-guide-mode)))

;; 配置行号显示样式
(require 'linum)
(setq linum-format "%4d ")

;; 宽度标尺，与company的样式有冲突，不要自启动，使用M-x fci-mode启动
(require-package 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "dark gray")

;; 选中region高亮
(transient-mark-mode t)

;; 高亮当前行
(global-hl-line-mode 1)

;; 高亮转义字符
(require-package 'highlight-escape-sequences)
(hes-mode)

;; 指示文件尾空行的横杠,t表示打开，nil表示关闭，可以通过M-x toggle-indicate-empty-lines关闭或者打开
;; 同 indicate-unused-lines
(setq indicate-empty-lines t)
;; 左侧添加文件指示的标示，在文件中间时间箭头，在头部和尾部显示一个L型标识
(setq indicate-buffer-boundaries 'left)

;; 让原来对一个词的定位由整个词整个词变成一次定位词中有意义的一部分
;; https://github.com/purcell/emacs.d/issues/138
(when (eval-when-compile (string< "24.3.1" emacs-version))
  (with-eval-after-load 'subword
    (diminish 'subword-mode)))

;; 调整光标覆盖单词面积
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; 跳到你想要的位置
(when (require-package 'avy)
  (global-set-key (kbd "C-;") 'avy-goto-word-or-subword-1))

(defun my/editor/backward-up-sexp (arg)
  "跳到包围当前表达式、代码块或者字符串的前ARG层括号处.
解决backwark-up-list函数不能识别包围字符串的引号的问题.
参数ARG表示执行到的层数,负数表示往右括号跳."
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (backward-up-sexp (1- arg)))
          ((backward-up-list arg)))))
;; 使用快捷键C-M-u
(global-set-key [remap backward-up-list] 'my/editor/backward-up-sexp)

;; 创建新行使用和前面文本同样的缩进
(global-set-key (kbd "RET") 'newline-and-indent)

(defun my/editor/newline-at-end-of-line ()
  "下方创建一个新行，光标移到行首."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
(global-set-key (kbd "S-<return>") 'my/editor/newline-at-end-of-line)

(defun my/editor/newline-at-beginnging-of-line ()
  "上方创建一个新行，光标移到行首."
  (interactive)
  (previous-line)
  (my/editor/newline-at-end-of-line)
  )
(global-set-key (kbd "S-M-<return>") 'my/editor/newline-at-beginnging-of-line)

;; 在行首C-k时，同时删除末尾换行符,让光标移到下一行的行首
(setq kill-whole-line t)

(defun my/editor/kill-back-to-indentation ()
  "从当前位置删除到行首缩进位置."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))
(global-set-key (kbd "C-M-<backspace>") 'my/editor/kill-back-to-indentation)

;; 浏览所有被剪切/复制(kill)的内容,并且可以选择一个进行粘贴(yank)
(require-package 'browse-kill-ring)
(setq browse-kill-ring-separator "\f")
(global-set-key (kbd "M-Y") 'browse-kill-ring)
(with-eval-after-load 'browse-kill-ring
  (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit)
  (define-key browse-kill-ring-mode-map (kbd "M-n") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "M-p") 'browse-kill-ring-previous))

;; 设置系统粘贴板的复制、剪切、粘贴
(global-set-key (kbd "C-c c") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-c x") 'clipboard-kill-region)
(global-set-key (kbd "C-c v") 'clipboard-yank)

(provide 'init-editor)
;;;  init-editor.el ends here
