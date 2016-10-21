;;; package -- 编辑配置
;;; Commentary:
;;; Code:


;; 把整段变成很多行
(require-package 'unfill)

;; 在行首C-k时，同时删除末尾换行符,让光标移到下一行的行首
(setq kill-whole-line t)

;; 成对插入符号
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

;; 显示匹配的符号
(require 'paren)
(show-paren-mode 1)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "brightgreen")

;; 选中region高亮
(transient-mark-mode t)

;; 配置行号显示
(require 'linum)
(setq linum-format "%4d ")
(toggle-indicate-empty-lines nil)

;; 宽度标尺
(require-package 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "white")

;; 基本配置
(setq-default
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
 indicate-empty-lines nil ;; 不显示文件结尾
 truncate-lines nil
 truncate-partial-width-windows nil)

;; 显示空格信息
(defun my/trailing-whitespace ()
  "Turn off display of trailing whitespace in this buffer."
  (setq show-trailing-whitespace t))
(dolist (hook '(emacs-lisp-mode c++-mode-hook))
  (add-hook hook #'my/trailing-whitespace))

;; 删除多余空白
(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)
(global-set-key [remap just-one-space] 'cycle-spacing)

;; 高亮当前行
;;(global-hl-line-mode 1)
;;(set-face-background hl-line-face "color-66")

;; 恢复buffer到最原始的状态，会删除undo数据，注意使用
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;; 创建新行操作,按下RET时既建新行也进行格式化
(global-set-key (kbd "RET") 'newline-and-indent)
(defun my/newline-at-end-of-line ()
  "移动到行尾并添加一个新行."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
;; TODO 暂时还无法解决使用S-RET的问题，后面想办法改成shift-RET
(global-set-key (kbd "M-RET") 'my/newline-at-end-of-line)

;; 自定义的粘贴复制剪切
(defun my/pbcopy ()
  "自定义的复制."
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))

(defun my/pbcut ()
  "自定义的剪切."
  (interactive)
  (my/pbcopy)
  (delete-region (region-beginning) (region-end)))

(defun my/pbpaste ()
  "自定义的粘贴."
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

;; 让原来对一个词的定位由整个词整个词变成一次定位词中有意义的一部分
;; https://github.com/purcell/emacs.d/issues/138
(after-load 'subword
  (diminish 'subword-mode))

;; 对于对齐结果显示一根对齐竖线(有一个问题就是文件大的话会比较慢)
;;(when (maybe-require-package 'indent-guide)
;;  (add-hook 'prog-mode-hook 'indent-guide-mode)
;;  (after-load 'indent-guide
;;    (diminish 'indent-guide-mode)))

;; 使用undo树
(require-package 'undo-tree)
(require 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

;; 调整光标覆盖单词面积
(require-package 'expand-region)
(require 'expand-region)
(global-set-key (kbd "C-c =") 'er/expand-region)

;; 浏览所有被剪切/复制(kill)的内容,并且可以选择一个进行粘贴(yank)
(require-package 'browse-kill-ring)
(require 'browse-kill-ring)
(setq browse-kill-ring-separator "\f")
(global-set-key (kbd "C-c y") 'browse-kill-ring)

;; 跳到你想要的位置
(require-package 'avy)
(require 'avy)
(global-set-key (kbd "C-c j") 'avy-goto-char)

;; 提供快捷键提示
(when (require-package 'guide-key)
  (require 'guide-key)
  (setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r"))
  (guide-key-mode 1)
  (diminish 'guide-key-mode))

;; iedit配置,可以将相同的内容一起改
(require-package 'iedit)
(require 'iedit)

(provide 'init-editing-utils)
;;;  init-editing-utils.el ends here
