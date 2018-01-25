;;; private/chrome/config.el -*- lexical-binding: t; -*-

(def-package! atomic-chrome
  :hook (doom-post-init . atomic-chrome-start-server)
  :config
  (setq atomic-chrome-default-major-mode 'org-mode)
  (setq atomic-chrome-url-major-mode-alist
        '(("github" . gfm-mode)
          ("gitlab" . gfm-mode)))
  (setq atomic-chrome-buffer-open-style 'frame)
  (add-hook 'atomic-chrome-edit-done-hook 'delete-frame))
