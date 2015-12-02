(require-package 'projectile)

(require 'projectile)

(projectile-global-mode)
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)

(add-hook 'c-mode-hook 'projectile-mode)
(add-hook 'c++-mode-hook 'projectile-mode)
(add-hook 'python-mode-hook 'projectile-mode)

(provide 'init-projectile)
