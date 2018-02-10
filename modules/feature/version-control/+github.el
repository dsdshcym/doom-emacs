;;; feature/version-control/+github.el -*- lexical-binding: t; -*-

(use-package magithub
  :after magit
  :config
  (setq magithub-dir (concat doom-cache-dir "magithub/"))
  (magithub-feature-autoinject t))
