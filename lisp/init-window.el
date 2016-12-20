;;; package -- 面板配置
;;; Commentary:
;;; Code:

;; 使用C-c <left> 和C-c <right>来对窗口配置进行 redo 或者 undo。这样在窗口乱了后可以恢复到原来不乱的状态
(when (fboundp 'winner-mode) (winner-mode 1))

;; 使用 shift+方向键 选择面板
(when (fboundp 'windmove-default-keybindings) (windmove-default-keybindings))

;; 超过两个窗口，可以使用"C-x o"进行切换
(require-package 'switch-window)
(require 'switch-window)
(setq-default switch-window-shortcut-style 'alphabet)
(setq-default switch-window-timeout nil)
(global-set-key (kbd "C-x o") 'switch-window)

;; 触发删除其它窗口
(defun my/window/toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode
           (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))
(global-set-key "\C-x1" 'my/window/toggle-delete-other-windows)

(defun my/window/split-window-func-with-other-buffer (split-function)
  "分屏并且把焦点放在新的window上, SPLIT-FUNCTION为分屏函数."
  (lexical-let ((s-f split-function))
    (lambda (&optional arg)
      "Split this window and switch to the new window unless ARG is provided."
      (interactive "P")
      (funcall s-f)
      (let ((target-window (next-window)))
        (set-window-buffer target-window (other-buffer))
        (unless arg
          (select-window target-window))))))
(global-set-key "\C-x2" (my/window/split-window-func-with-other-buffer 'split-window-vertically))
(global-set-key "\C-x3" (my/window/split-window-func-with-other-buffer 'split-window-horizontally))

;; 设置分屏, C-x |和C-x _分别表示竖分和横分。使用这个操作的时候只会一直只有两个window
(defun my/window/split-window-horizontally-instead ()
  "横向分割."
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (my/window/split-window-func-with-other-buffer 'split-window-horizontally))))
(global-set-key "\C-x|" 'my/window/split-window-horizontally-instead)

(defun my/window/split-window-vertically-instead ()
  "纵向分割."
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (my/window/split-window-func-with-other-buffer 'split-window-vertically))))
(global-set-key "\C-x_" 'my/window/split-window-vertically-instead)

(provide 'init-window)
;;;  init-window.el ends here
