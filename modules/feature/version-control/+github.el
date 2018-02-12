;;; feature/version-control/+github.el -*- lexical-binding: t; -*-

(use-package magithub
  :after magit
  :init
  (autoload 'magithub-completion-enable "magithub-completion")
  :config
  (setq magithub-dir (concat doom-cache-dir "magithub/"))
  (magithub-feature-autoinject t))
