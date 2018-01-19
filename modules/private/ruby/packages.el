;; -*- no-byte-compile: t; -*-
;;; private/ruby/packages.el

(package! inf-ruby)
(when (featurep! :completion company)
  (package! company-inf-ruby))

(package! robe)
(package! bundler)
(package! rspec-mode)
(package! minitest)
(package! rbenv)
(package! rubocop)
(package! projectile-rails)
(package! rake)
