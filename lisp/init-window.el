;;; package -- 面板配置
;;; Commentary:
;;; Code:

(config-after-fetch-require 'winner
  ;; 使用 C-c <left> 和 C-c <right> 来对窗口配置进行 redo 或者 undo。这样在窗口乱了后可以恢复到原来不乱的状态
  (winner-mode 1)

  (with-eval-after-load 'ido
    (config-after-fetch-require 'ido-select-window
      (global-set-key (kbd "C-x o") 'ido-select-window))
    )

  (config-bind-global-key (kbd "C-x 1")
    ;; 删除其它面板，如果没有其它面板就恢复前一个面板布局
    (if (and winner-mode (equal (selected-window) (next-window)))
	(winner-undo)
      (delete-other-windows)
      )
    )
  )

(config-bind-global-key (kbd "C-x 2")
  ;; 左右分屏
  (split-window-vertically)
  (set-window-buffer (next-window) (other-buffer))
  )

(config-bind-global-key (kbd "C-x 3")
  ;; 上下分屏
  (split-window-horizontally)
  (set-window-buffer (next-window) (other-buffer))
  )

(provide 'init-window)
;;;  init-window.el ends here
