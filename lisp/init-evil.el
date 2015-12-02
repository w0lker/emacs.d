(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-surround)

(setq evil-leader/leader ";"
      evil-leader/in-all-states t)

(evil-leader/set-key
  "Y" (kbd "y$")
  "f" 'find-file
  "d" 'find-dired
  "r" 'iedit-mode
  "b" 'ibuffer
  "k" 'kill-buffer
  "w" 'save-buffer
  "W" 'save-some-buffers
  "g" 'avy-goto-char
  "p" 'md/duplicate-down
  "P" 'md/duplicate-up
  "n" 'editing/newline-at-end-of-line)

(global-evil-leader-mode)
(evil-mode 1)



(provide 'init-evil)
