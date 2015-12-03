(require-package 'cedet)

;; 语法分析，可以将当前类目录的头文件中的symbol解析出来
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;; ede-mode 添加要分析的项目信息
(global-ede-mode t)
(ede-cpp-root-project "my project" :file "~/Works/test/hello_emacs/demos/my_program/src/main.cpp" :include-path '("/../my_inc"))

;; 设置代码分析的时间
(global-semantic-idle-scheduler-mode 2)

(provide 'init-cedet)
