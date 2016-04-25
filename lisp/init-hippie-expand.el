;; 补全工具，当按下配置的M-/会尽力使用已经出现过的词进行补全,不断的按M-/可以在很多出现的以输入的词开头的词中切换
(global-set-key (kbd "M-/") 'hippie-expand)

(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))

(provide 'init-hippie-expand)
