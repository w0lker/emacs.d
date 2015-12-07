(require-package 'cedet)

;; 语法分析，可以将当前类目录的头文件中的symbol解析出来
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;; ede-mode 添加要分析的project信息
(global-ede-mode t)

;; 设置代码分析的时间
(global-semantic-idle-scheduler-mode 2)

(global-set-key (kbd "C-c j") 'semantic-ia-fast-jump)

(provide 'init-cedet)
