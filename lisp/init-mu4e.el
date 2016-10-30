;;; Package -- Email设置
;;; Commentary:
;;; Code:

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)
(setq mu4e-mu-binary "/usr/local/bin/mu")
;; 使用mu4e作为默认邮件代理
(setq mail-user-agent 'mu4e-user-agent)
;; 存放文件夹
(setq mu4e-maildir "~/Documents/Mails")
;; 通过offlineimap获得邮件
(setq mu4e-get-mail-command "offlineimap")
;; 获取邮件频率
(setq mu4e-update-interval 300)

;; 发件箱
(setq mu4e-sent-folder   "/Secoo/Sent Messages")
;; 草稿箱
(setq mu4e-drafts-folder "/Secoo/Drafts")
;; 垃圾箱
(setq mu4e-trash-folder  "/Secoo/Deleted Messages")
;; 设置快捷键
(setq mu4e-maildir-shortcuts  '(("/Secoo/INBOX" . ?i)
                                ("/Sent Messages" . ?s)
                                ("/Deleted Messages" . ?t)
                                ("/All Mail" . ?a)))

(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)
(add-hook 'mu4e-view-mode-hook
          (lambda ()
            (local-set-key (kbd "<tab>") 'shr-next-link)
            (local-set-key (kbd "<backtab>") 'shr-previous-link)))
;; 显示图片
(setq mu4e-view-show-images t)

;; SMTP setup
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      starttls-use-gnutls t)
(setq user-full-name "tangjun")
(setq user-mail-address "tangjun@secoo.com")
(setq smtpmail-smtp-server "smtp.exmail.qq.com")
(setq smtpmail-smtp-service 465)
(setq smtpmail-smtp-user "tangjun@secoo.com")
;; 邮件签名
(setq mu4e-compose-signature "From my emacs.")

(provide 'init-mu4e)
;;;  init-mu4e.el ends here
