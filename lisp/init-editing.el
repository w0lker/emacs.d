(require-package 'unfill)

;; 成对插入符号
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

;; 显示匹配的符号
(show-paren-mode 1)

;; 基本配置
(setq-default
 blink-cursor-interval 0.4 ;; 光标闪动频率
 case-fold-search t ;; 搜索是大小写不敏感,nil表示敏感
 column-number-mode t
 delete-selection-mode t ;; 可以像普通编辑器一样用delete删除
 ediff-split-window-function 'split-window-horzontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil ;; 使用空格代替tab进行缩进
 tab-width 4
 make-backup-files nil ;; 有版本控制系统，无必要
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 show-trailing-whitespace t ;; 显示空格信息
 truncate-lines nil
 truncate-partial-width-windows nil)

;; 删除空格
(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)
(global-set-key [remap just-one-space] 'cycle-spacing)

;; 高亮当前行
(global-hl-line-mode 1)
(set-face-background hl-line-face "gray20")

;; 恢复buffer到最原始的状态，会删除undo数据，注意使用
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;; 选中region高亮
(transient-mark-mode t)

;; 创建新行操作
(global-set-key (kbd "RET") 'newline-and-indent)
(defun editing/newline-at-end-of-line ()
  "移动到行尾并添加一个新行"
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
(global-set-key (kbd "M-RET") 'editing/newline-at-end-of-line)

;; 自定义的粘贴复制剪切
(defun editing/pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))
(defun editing/pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))
(defun editing/pbcut ()
  (interactive)
  (editing/pbcopy)
  (delete-region (region-beginning) (region-end)))
(global-set-key (kbd "C-c c") 'editing/pbcopy)
(global-set-key (kbd "C-c v") 'editing/pbpaste)
(global-set-key (kbd "C-c x") 'editing/pbcut)
(global-set-key (kbd "C-c z") 'undo)
(global-set-key (kbd "C-c s") 'set-mark-command)

;; 让原来对一个词的定位由整个词整个词变成一次定位词中有意义的一部分
(when (eval-when-compile (string< "24.3.1" emacs-version))
  ;; https://github.com/purcell/emacs.d/issues/138
  (after-load 'subword
    (diminish 'subword-mode)))

;; 使用undo树
(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

;; 调整光标覆盖单词面积
(require-package 'expand-region)
(global-set-key (kbd "C-c =") 'er/expand-region)

;; 浏览所有被剪切/复制(kill)的内容,并且可以选择一个进行粘贴(yank)
(require-package 'browse-kill-ring)
(setq browse-kill-ring-separator "\f")
(global-set-key (kbd "C-c y") 'browse-kill-ring)

;; 跳到你想要的位置
(require-package 'avy)
(global-set-key (kbd "C-c j") 'avy-goto-char)

;; 文档查找
(setq-default grep-highlight-matches t
              grep-scroll-output t)
(when *is-a-mac*
  (setq-default locate-command "mdfind"))
(when (executable-find "ag")
  (require-package 'ag)
  (require-package 'wgrep-ag)
  (setq-default ag-highlight-search t)
  (global-set-key (kbd "M-?") 'ag-project))

;; 向上或者向下复制当前行
(require-package 'move-dup)
(global-set-key (kbd "C-c p") 'md/duplicate-down)
(global-set-key (kbd "C-c P") 'md/duplicate-up)

;; 如果没选择就copy/cut当前行
(require-package 'whole-line-or-region)
(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)

;; 提供快捷键提示
(require-package 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
(guide-key-mode 1)
(diminish 'guide-key-mode)

;; iedit配置,可以将相同的内容一起改
(require-package 'iedit)
; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

(provide 'init-editing)
