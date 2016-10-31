;;; package -- 版本控制
;;; Commentary:
;;; Code:

;; 修改内容左侧显示提示
(require-package 'diff-hl)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

;; ibuffer添加版本控制信息
(require-package 'ibuffer-vc)
(add-hook 'ibuffer-hook 'ibuffer-vc-set-filter-groups-by-vc-root)

(provide 'init-vc)
;;;  init-vc.el ends here
