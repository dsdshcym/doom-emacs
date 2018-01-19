;;; private/ruby/+rails.el -*- lexical-binding: t; -*-

(def-package! projectile-rails
  :after (ruby-mode projectile)
  :config
  (set! :popup "rails-server\\*$" '((size . 0.25)) '((quit)))
  (set! :popup "\\*rails\\*" '((size . 0.25)) '((quit)))
  (projectile-rails-global-mode))
