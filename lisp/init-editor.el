;;; package -- 编辑器
;;; Commentary:
;;; Code:

;; 基本配置
(setq-default
 major-mode 'text-mode ;; 默认模式不使用fundamental-mode
 jit-lock-defer-time 0.05 ;; 优化翻页速度
 blink-cursor-interval 0.4 ;; 光标闪动频率
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
 tooltip-delay 1.5
 show-trailing-whitespace nil ;; 默认不显示空格信息
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t ;; 关闭出错蜂鸣声
 ring-bell-function 'ignore)

;; 统一使用y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; 设置redo支持
(require-package 'redo+)
(global-set-key (kbd "C-?") 'redo)
(setq undo-no-redo t)

;; 禁用鼠标
;;(require-package 'disable-mouse)
;;(global-disable-mouse-mode)

;;
;; 不断监听当前buffer的变化，如果有其它编辑器修改该文件会同步过来
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;; 在行首C-k时，同时删除末尾换行符,让光标移到下一行的行首
(setq kill-whole-line t)

;; 成对插入符号
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

;; 显示匹配的符号
(show-paren-mode 1)

;; 让不同级别的括号显示不同颜色
(when (require-package 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; 选中region高亮
(transient-mark-mode t)

;; 配置行号显示
(require 'linum)
(setq linum-format "%4d ")

;; 通过横杠指示文件结尾空行
;; 可以通过M-x toggle-indicate-empty-lines关闭或者打开
(setq indicate-empty-lines t)
(setq indicate-buffer-boundaries 'right)

;; 宽度标尺，与company的样式有冲突，不要自启动
(require-package 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "dark gray")

;; 删除多余空白
(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)
(global-set-key [remap just-one-space] 'cycle-spacing)

;; 高亮当前行
;;(global-hl-line-mode 1)

;; 创建新行操作,按下RET时既建新行也进行格式化
(global-set-key (kbd "RET") 'newline-and-indent)

;; 在当前行任意位置使用shift-RET创建一个新行
(defun my/newline-at-end-of-line ()
  "移动到行尾并添加一个新行."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
;; 一定要使用<return>形式，快捷键Shift-<return>
(global-set-key (kbd "S-<return>") 'my/newline-at-end-of-line)

;; 删除到行首第一个非空白字符处
(defun my/kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))
(global-set-key (kbd "C-M-<backspace>") 'my/kill-back-to-indentation)

;; 会修改编码字符（如：lambda为λ）使其更容易读
(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))

;; 让原来对一个词的定位由整个词整个词变成一次定位词中有意义的一部分
;; https://github.com/purcell/emacs.d/issues/138
(when (eval-when-compile (string< "24.3.1" emacs-version))
  (after-load 'subword
    (diminish 'subword-mode)))

;; 对于对齐结果显示一根对齐竖线(有一个问题就是文件大的话会比较慢)
(when (maybe-require-package 'indent-guide)
  (add-hook 'prog-mode-hook 'indent-guide-mode)
  (after-load 'indent-guide
    (diminish 'indent-guide-mode)))

;; 使用undo树
(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

;; 高亮被转移的字符
(require-package 'highlight-escape-sequences)
(hes-mode)

;; 关闭缩小选中位置配置
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; 调整光标覆盖单词面积
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; 浏览所有被剪切/复制(kill)的内容,并且可以选择一个进行粘贴(yank)
(require-package 'browse-kill-ring)
(setq browse-kill-ring-separator "\f")
(global-set-key (kbd "M-Y") 'browse-kill-ring)
(after-load 'browse-kill-ring
  (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit)
  (define-key browse-kill-ring-mode-map (kbd "M-n") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "M-p") 'browse-kill-ring-previous))
(after-load 'page-break-lines
  (push 'browse-kill-ring-mode page-break-lines-modes))

;; 跳到你想要的位置
(when (maybe-require-package 'avy)
  (global-set-key (kbd "C-;") 'avy-goto-word-or-subword-1))

;; 将丑陋的换行提示符^L显示为一条线
(require-package 'page-break-lines)
(global-page-break-lines-mode)
(diminish 'page-break-lines-mode)

;; 跳到当前表达式或者代码块的最前面
;; Fix backward-up-list to understand quotes, see http://bit.ly/h7mdIL
(defun my/backward-up-sexp (arg)
  "Jump up to the start of the ARG'th enclosing sexp."
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (backward-up-sexp (1- arg)))
          ((backward-up-list arg)))))
(global-set-key [remap backward-up-list] 'my/backward-up-sexp) ; C-M-u, C-M-up

;; 提供快捷键提示
(when (require-package 'guide-key)
  (require 'guide-key)
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (guide-key-mode 1)
  (diminish 'guide-key-mode))

(provide 'init-editor)
;;;  init-editor.el ends here
