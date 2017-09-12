;;; package -- Tramp 配置
;;; Commentary:
;;; Code:

(with-eval-after-load 'tramp
  (setq-default tramp-persistency-file-name (concat user-temp-dir "tramp"))

  ;; 指定默认使用的方法
  ;; 使用ssh会比scp快
  ;; 在使用的时候，可以临时指定其它的方法
  ;; C-x C-f /method:user@remotehost:filename
  (setq tramp-default-method "ssh")

  ;; 优化大文件的网络传输，如问题：tramp: Waiting for remote host to process data
  (setq tramp-chunksize 500)

  (defun tramp-shell (&optional buffer)
    "当使用tramp连到某个远程文件后，创建一个连接到当前远程文件的shell BUFFER."
    (interactive)
    (let* ((tramp-path (when (tramp-tramp-file-p default-directory)
			 (tramp-dissect-file-name default-directory)))
	   (host (tramp-file-name-real-host tramp-path))
	   (user (if (tramp-file-name-user tramp-path)
		     (format "%s@" (tramp-file-name-user tramp-path)) ""))
	   (new-buffer-name (format "*shell:%s%s*" user host)))
      (shell (if host new-buffer-name buffer))))

  (config-after-fetch-require 'vagrant
    (config-after-fetch-require 'vagrant-tramp)
    )
  )

(provide 'init-tramp)

;; Local Variables:
;; coding: utf-8
;; End:

;;; init-tramp.el ends here
