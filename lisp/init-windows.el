;;----------------------------------------------------------------------------
;; Navigate window layouts with "C-c <left>" and "C-c <right>"
;;----------------------------------------------------------------------------
(winner-mode 1)


;; 超过两个窗口，可以使用"C-x o"进行切换
(require-package 'switch-window)
(require 'switch-window)
(setq-default switch-window-shortcut-style 'alphabet)
(setq-default switch-window-timeout nil)
(global-set-key (kbd "C-x o") 'switch-window)

;; 分出的窗口使用新的缓冲区
;;(defun split-window-func-with-other-buffer (split-function)
;;  (lexical-let ((s-f split-function))
;;    (lambda (&optional arg)
;;      "Split this window and switch to the new window unless ARG is provided."
;;      (interactive "P")
;;      (funcall s-f)
;;      (let ((target-window (next-window)))
;;        (set-window-buffer target-window (other-buffer))
;;        (unless arg
;;          (select-window target-window))))))
;;
;;(global-set-key "\C-x2" (split-window-func-with-other-buffer 'split-window-vertically))
;;(global-set-key "\C-x3" (split-window-func-with-other-buffer 'split-window-horizontally))

(defun my/toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode
           (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

(global-set-key "\C-x1" 'my/toggle-delete-other-windows)

;;----------------------------------------------------------------------------
;; Rearrange split windows
;;----------------------------------------------------------------------------
(defun split-window-horizontally-instead ()
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (split-window-func-with-other-buffer 'split-window-horizontally))))

(defun split-window-vertically-instead ()
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (split-window-func-with-other-buffer 'split-window-vertically))))

(global-set-key "\C-x|" 'split-window-horizontally-instead)
(global-set-key "\C-x_" 'split-window-vertically-instead)


;; Borrowed from http://postmomentum.ch/blog/201304/blog-on-emacs
(defun my/split-window()
    "Split the window to see the most recent buffer in the other window.
Call a second time to restore the original window configuration."
    (interactive)
    (if (eq last-command 'my/split-window)
        (progn
          (jump-to-register :my/split-window)
          (setq this-command 'my/unsplit-window))
      (window-configuration-to-register :my/split-window)
      (switch-to-buffer-other-window nil)))

(global-set-key (kbd "<f7>") 'my/split-window)



(defun my/toggle-current-window-dedication ()
  "Toggle whether the current window is dedicated to its current buffer."
  (interactive)
  (let* ((window (selected-window))
         (was-dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not was-dedicated))
    (message "Window %sdedicated to %s"
             (if was-dedicated "no longer " "")
             (buffer-name))))

(global-set-key (kbd "C-c <down>") 'my/toggle-current-window-dedication)



(unless (memq window-system '(nt w32))
  (windmove-default-keybindings 'control))


(provide 'init-windows)
