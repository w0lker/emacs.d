;;; package -- 编辑器
;;; Commentary:
;;; Code:

;; 默认主模式为 text-mode
(setq major-mode 'text-mode)

;; 优化翻页速度
(setq jit-lock-defer-time 0.05)

;; 关闭出错蜂鸣声
(setq visible-bell t
      ring-bell-function 'ignore)

;; 设置自动保存目录
(setq  auto-save-list-file-prefix (concat user-emacs-directory
                                          (file-name-as-directory my-temp-dir)
                                          (file-name-as-directory "auto-save-list")
                                          "saves-"))

;; 不断监听当前 buffer 的变化，如果其它编辑器同时修改该文件，修改会同步过来
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)
(global-auto-revert-mode)

;; 光标闪动频率
(setq  blink-cursor-interval 0.5)

;; 滚动屏幕时，光标位置不变
(setq scroll-preserve-screen-position 'always)

;; 取消不管多少个空行只显示一行
(setq truncate-lines nil
      truncate-partial-width-windows nil)

;; 默认不显示空格信息
(setq show-trailing-whitespace nil)

;; 使用空格代替tab键
(setq indent-tabs-mode nil
      tab-width 4)

;; mode-line 上显示列数
(setq  column-number-mode t)

;; 可以像普通编辑器一样用delete删除
(setq  delete-selection-mode t)

;; 同时删除末尾换行符
(setq kill-whole-line t)

;; 自动将其它程序加入系统剪切板的内容加入 kill-ring
(setq save-interprogram-paste-before-kill nil)

;; 不用点击直接拷贝鼠标下面内容
(setq mouse-yank-at-point t)

;; 打标记时，每次 C-SPC 算不同的标记记录
(setq set-mark-command-repeat-pop t)

;; 关闭 narrowing 功能，使用 narrowing 功能，可以在 buffer 中只显示选中的区域的内容，其它部分隐藏，比较容易造成困惑
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; 配置 undo 树
(require-package 'undo-tree)
(global-undo-tree-mode)
(with-eval-after-load 'undo-tree
  (diminish 'undo-tree-mode))

;; 设置 redo
(require-package 'redo+)
(setq undo-no-redo t)
(global-set-key (kbd "C-?") 'redo)

;; 成对插入符号
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))

;; 括号自动缩进
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

;; 高亮匹配的括号
(show-paren-mode 1)

;; 对于对齐结果显示一根对齐竖线(有一个问题就是文件大的话会比较慢，如果程序打开大文件比较慢可以考虑关闭)
(when (require-package 'indent-guide)
  (add-hook 'prog-mode-hook 'indent-guide-mode)
  (with-eval-after-load 'indent-guide
    (diminish 'indent-guide-mode)))

;; 配置行号显示样式
(require 'linum)
(setq linum-format "%4d ")

;; 宽度标尺，与 company 的样式有冲突，不要自启动，使用 M-x fci-mode 启动
(require-package 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "dark gray")

;; 选中 region 高亮
(transient-mark-mode t)

;; 高亮转义字符
(require-package 'highlight-escape-sequences)
(hes-mode)

;; 指示文件尾空行的横杠,t 表示打开，nil 表示关闭，可以通过 M-x toggle-indicate-empty-lines 关闭或者打开
;; 同 indicate-unused-lines
(setq-default indicate-empty-lines nil)
;; 左侧添加文件指示的标示，在文件中间时间箭头，在头部和尾部显示一个 L 型标识
(setq-default indicate-buffer-boundaries '((up . left) (down . left)))

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
  "跳到包围当前表达式、代码块或者字符串的前 ARG 层括号处.
解决 backwark-up-list 函数不能识别包围字符串的引号的问题.
参数 ARG 表示执行到的层数,负数表示往右括号跳."
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (backward-up-sexp (1- arg)))
          ((backward-up-list arg)))))
;; 使用快捷键 C-M-u
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
