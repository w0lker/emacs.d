;;; package -- 面板配置
;;; Commentary:
;;; Code:

(fetch-package 'windmove)
(fetch-package 'winner)

;; 使用 shift+方向键 选择面板
(require 'windmove)
(windmove-default-keybindings)

;; 使用C-c <left> 和C-c <right>来对窗口配置进行 redo 或者 undo。这样在窗口乱了后可以恢复到原来不乱的状态
(require 'winner)
(winner-mode 1)
(defun window/delete-other-windows-or-restore-previous ()
  "删除其它面板，如果没有其它面板就恢复前一个面板布局."
  (interactive)
  (if (and winner-mode
	   (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))
(global-set-key "\C-x1" 'window/delete-other-windows-or-restore-previous)

(defun window/split-window-func-with-other-buffer (split-function)
  "分屏并且把焦点放在新面板上, SPLIT-FUNCTION 为分屏函数."
  (lexical-let ((s-f split-function))
    (lambda (&optional arg)
      (interactive "P")
      (funcall s-f)
      (let ((target-window (next-window)))
	(set-window-buffer target-window (other-buffer))
	(unless arg
	  (select-window target-window))))))
(global-set-key "\C-x2" (window/split-window-func-with-other-buffer 'split-window-vertically))
(global-set-key "\C-x3" (window/split-window-func-with-other-buffer 'split-window-horizontally))

;; 设置分屏, C-x |和C-x _分别表示竖分和横分。使用这个操作的时候只会一直只有两个window
(defun window/split-window-horizontally-instead ()
  "横向分割面板."
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (window/split-window-func-with-other-buffer 'split-window-horizontally))))
(global-set-key "\C-x|" 'window/split-window-horizontally-instead)

(defun window/split-window-vertically-instead ()
  "纵向分割面板."
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (window/split-window-func-with-other-buffer 'split-window-vertically))))
(global-set-key "\C-x_" 'window/split-window-vertically-instead)

(provide 'init-window)
;;;  init-window.el ends here
