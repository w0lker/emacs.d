;;; package -- cedet配置
;;; Commentary:
;;; Code:

;; 配置cedet
(when (maybe-require-package 'cedet)
  (semantic-mode 1)

  ;; 将语法分析的结果加入auto-complete的源当中
  (add-to-list 'ac-sources 'ac-source-semantic)

  ;; 配置cedet监控能解析的数据，如果某个数据无法解析到则使用高亮
  (global-semantic-decoration-mode 1)

  ;; 设置高亮的皮肤
  (custom-set-faces
   '(semantic-decoration-on-unknown-includes ((t (:background "brightmagenta")))))

  ;; 空闲5秒后就开始分析
  (global-semantic-idle-scheduler-mode 5)

  ;; 大于1M的数据就不分析
  (setq semantic-idle-scheduler-max-buffer-size 1000000)

  ;; 配置项目环境解析
  (global-ede-mode t))


(provide 'init-cedet)
;;;  init-cedet.el ends here
