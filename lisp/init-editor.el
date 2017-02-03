;;; package -- 编辑器
;;; Commentary:
;;; Code:

(fetch-package 'undo-tree)
(fetch-package 'redo+)
(fetch-package 'highlight-escape-sequences)
(fetch-package 'diff-hl)
(fetch-package 'expand-region)
(fetch-package 'avy)
(fetch-package 'rainbow-delimiters)

;; 默认主模式为 text-mode
(setq major-mode 'text-mode)

;; 优化翻页速度
(setq jit-lock-defer-time 0.05)

;; 关闭出错蜂鸣声
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; 不断监听当前 buffer 的变化，如果其它编辑器同时修改该文件，修改会同步过来
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)
(diminish 'auto-revert-mode)

;; 光标闪动频率
(setq blink-cursor-interval 0.8)

;; 取消不管多少个空行只显示一行
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; 默认不显示空格信息
(setq show-trailing-whitespace t)

;; 使用空格代替 TAB 键
(setq indent-tabs-mode nil)
(setq tab-width 4)

;; mode-line 上显示列数
(setq column-number-mode t)

;; 可以像普通编辑器一样用delete删除
(setq delete-selection-mode t)

;; 同时删除末尾换行符
(setq kill-whole-line t)

;; 自动将其它程序加入系统剪切板的内容加入 kill-ring
(setq save-interprogram-paste-before-kill nil)

;; primary section中内容不放入系统剪切版
(setq select-enable-primary nil)
;; 不把当前选中的选区中的内容放入primary section
(setq select-active-regions nil)

;; 剪切复制使用系统剪切板
(setq select-enable-clipboard t)

;; 打标记时，每次 C-SPC 算不同的标记记录
(setq set-mark-command-repeat-pop t)

;; 关闭 narrowing 功能，使用 narrowing 功能，可以在 buffer 中只显示选中的区域的内容，其它部分隐藏，比较容易造成困惑
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

(require 'undo-tree)
(global-undo-tree-mode t)
(diminish 'undo-tree-mode)

(require 'redo+)
(setq undo-no-redo t)
(global-set-key (kbd "C-?") 'redo)

;; 成对插入符号
(if (fboundp 'electric-pair-mode)
    (electric-pair-mode))

;; 高亮匹配的括号
(show-paren-mode 1)

;; 不同层括号颜色不同
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; 配置行号显示样式
(require 'linum)
(setq linum-format "%4d ")

;; 选中 region 高亮
(transient-mark-mode t)

;; 高亮转义字符
(require 'highlight-escape-sequences)
(hes-mode t)

;; 指示文件尾空行的横杠,t 表示打开，nil 表示关闭，可以通过 M-x toggle-indicate-empty-lines 关闭或者打开
;; 同 indicate-unused-lines
(setq-default indicate-empty-lines nil)
;; 左侧添加文件指示的标示，在文件中间时间箭头，在头部和尾部显示一个 L 型标识
(setq-default indicate-buffer-boundaries '((up . left) (down . left)))

;; 左侧显示提示修改内容
(require 'diff-hl)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

;; 调整光标覆盖单词面积
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; 跳到你想要的位置
(require 'avy)
(global-set-key (kbd "C-;") 'avy-goto-word-or-subword-1)

(defun editor/backward-up-sexp (arg)
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
(global-set-key [remap backward-up-list] 'editor/backward-up-sexp)

;; 创建新行使用和前面文本同样的缩进
(global-set-key (kbd "RET") 'newline-and-indent)

(defun editor/newline-at-end-of-line ()
  "下方创建一个新行，光标移到行首."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
(global-set-key (kbd "S-<return>") 'editor/newline-at-end-of-line)

(defun editor/newline-at-beginnging-of-line ()
  "上方创建一个新行，光标移到行首."
  (interactive)
  (previous-line)
  (editor/newline-at-end-of-line))
(global-set-key (kbd "S-M-<return>") 'editor/newline-at-beginnging-of-line)

(defun editor/kill-back-to-indentation ()
  "从当前位置删除到行首缩进位置."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))
(global-set-key (kbd "C-M-<backspace>") 'editor/kill-back-to-indentation)

(provide 'init-editor)
;;;  init-editor.el ends here
