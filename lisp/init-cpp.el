;; 配置在源码和头文件之间切换，如果文件不存在可以自动创建
(add-hook 'c-mode-common-hook
          (lambda()
                (local-set-key  (kbd "C-c o") 'ff-find-related-file)))

(provide 'init-cpp)
