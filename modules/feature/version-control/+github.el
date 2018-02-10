;;; feature/version-control/+github.el -*- lexical-binding: t; -*-

(use-package magithub
  :after magit
  :config
  (magithub-feature-autoinject t))
