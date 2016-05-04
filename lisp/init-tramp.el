;;; package --- tramp-mode配置
;;; Commentary:
;;; Code:

;; 指定默认使用的方法
;; 在使用的时候，可以临时指定其它的方法
;; C-x C-f /method:user@remotehost:filename
(setq tramp-default-method "ssh")

(defun tramp-shell (&optional buffer)
   "当使用tramp连到某个远程文件后，使用M-x tramp-shell创建一个连接到当前远程文件的shell。"
   (interactive)
   (let* ((tramp-path (when (tramp-tramp-file-p default-directory)
                        (tramp-dissect-file-name default-directory)))
          (host (tramp-file-name-real-host tramp-path))
          (user (if (tramp-file-name-user tramp-path)
                  (format "%s@" (tramp-file-name-user tramp-path)) ""))
          (new-buffer-name (format "*shell:%s%s*" user host)))
     (shell (if host new-buffer-name buffer))))

(provide 'init-tramp)
;;; init-tramp.el ends here
