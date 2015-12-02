(require-package 'evil)
(require-package 'evil-leader)

(setq evil-leader/leader ";"
      evil-leader/in-all-states t)

(evil-leader/set-key
  "f" 'find-file
  "d" 'dired
  "r" 'iedit-mode
  "b" 'ibuffer
  "k" 'kill-buffer
  "w" 'save-buffer
  "W" 'save-some-buffers
  "j" 'avy-goto-char
  "Y" 'browse-kill-ring
  "p" 'md/duplicate-down
  "P" 'md/duplicate-up
  "n" 'editing/newline-at-end-of-line)

(global-evil-leader-mode)

;; 设置evil模式的颜色
(setq evil-normal-state-tag (propertize "N" 'face '((:background "grey80" :foreground "green")))
      evil-emacs-state-tag (propertize "E" 'face '((:background "orange" :foreground "black")))
      evil-insert-state-tag (propertize "I" 'face '((:background "grey80" :foreground "red")))
      evil-motion-state-tag (propertize "M" 'face '((:background "blue")))
      evil-visual-state-tag (propertize "V" 'face '((:background "grey80" :foreground "black")))
      evil-operator-state-tag (propertize "O" 'face '((:background "purple"))))


(evil-mode 1)
(provide 'init-evil)
