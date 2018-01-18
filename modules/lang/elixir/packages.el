;; -*- no-byte-compile: t; -*-
;;; lang/elixir/packages.el

;; +elixir.el
(package! elixir-mode)
(package! ob-elixir)
(package! smartparens)
(package! alchemist)
(package! mix-format :recipe (:fetcher github :repo "anildigital/mix-format.el"))
