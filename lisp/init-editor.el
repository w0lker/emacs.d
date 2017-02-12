;;; package -- 编辑器配置
;;; Commentary:
;;; Code:

(setq initial-scratch-message nil ;; scratch默认不显示任何内容
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
      help-window-select t ;; 使用帮助时，焦点在帮助 buffer 上
      )

(setq-default indicate-empty-lines nil ;; 空行显示一个标识
	      indicate-buffer-boundaries '((up . left) (down . left))
	      )

(if (fboundp 'linum-mode)
    ;; 显示行号
    (linum-mode 1)
  )

(if (fboundp 'transient-mark-mode)
    ;; 选中 region 高亮
    (transient-mark-mode t)
  )

(if (fboundp 'electric-pair-mode)
    ;; 成对插入符号
    (electric-pair-mode 1)
  )

(if (fboundp 'show-paren-mode)
    ;; 高亮匹配的括号
    (show-paren-mode 1)
  )

(config-after-fetch-require 'default-text-scale
  ;; 字体大小调整
  (set-default-font "Menlo 13")
  (when window-system
    (global-set-key (kbd "C-M-=") 'default-text-scale-increase)
    (global-set-key (kbd "C-M--") 'default-text-scale-decrease)
    (defun editor/maybe-adjust-visual-fill-column ()
      "自动适配列数."
      (if visual-fill-column-mode
	  (add-hook 'after-setting-font-hook 'visual-fill-column--adjust-window nil t)
	(remove-hook 'after-setting-font-hook 'visual-fill-column--adjust-window t)))
    (add-hook 'visual-fill-column-mode-hook 'editor/maybe-adjust-visual-fill-column)
    )
  )

(config-after-require 'autorevert
  ;; 不断监听当前 buffer 的变化，如果其它编辑器同时修改该文件，修改会同步过来
  (global-auto-revert-mode)
  (setq global-auto-revert-non-file-buffers t
	auto-revert-verbose nil)
  (config-after-fetch-require 'diminish
    (diminish 'auto-revert-mode)
    )
  )

(config-after-fetch-require 'diff-hl
  ;; 左侧显示提示修改内容
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
  )

(config-after-fetch-require 'expand-region
  ;; 一层层的调整光标覆盖单词面积
  (global-set-key (kbd "C-=") 'er/expand-region)
  (global-set-key (kbd "C--") 'er/contract-region)
  )

(config-after-fetch-require 'smooth-scrolling
  ;; 平滑鼠标滚动
  (smooth-scrolling-mode t)
  )

(config-after-fetch-require 'undo-tree
  (global-undo-tree-mode t)
  (config-after-fetch-require 'diminish
    (diminish 'undo-tree-mode)
    )
  )

(config-after-fetch-require 'redo+
  (setq undo-no-redo t)
  (global-set-key (kbd "C-?") 'redo)
  )

(config-after-fetch-require 'rainbow-delimiters
  ;; 不同层括号颜色不同
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )

(config-after-fetch-require 'highlight-escape-sequences
  ;; 高亮转义字符
  (hes-mode t)
  )

(config-bind-global-key [remap backward-up-list]
  ;; 跳到包围当前表达式、代码块或者字符串的前层括号处
  ;; 解决 backwark-up-list 函数不能识别包围字符串的引号的问题
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (backward-up-sexp (1- arg)))
          ((backward-up-list arg)))
    )
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
  (editor/newline-at-end-of-line)
  )

(config-bind-global-key (kbd "C-M-<backspace>")
  ;; 从当前位置删除到行首缩进位置
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos))
  )


(provide 'init-editor)
;;;  init-editor.el ends here
