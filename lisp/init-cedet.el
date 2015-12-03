(require-package 'cedet)

;; 语法分析，可以将当前类目录的头文件中的symbol解析出来
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;; ede-mode 打开方便添加自定义的include类内容
(global-ede-mode t)
(ede-cpp-root-project "my project" :file "~/Works/test/hello_emacs/demos/my_program/src/main.cpp" :include-path '("/../my_inc"))

(global-semantic-idle-scheduler-mode 2)

(provide 'init-cedet)
