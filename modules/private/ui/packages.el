;; -*- no-byte-compile: t; -*-
;;; private/ui/packages.el

;; Revert to elpa version until
;; https://github.com/bbatsov/solarized-emacs/pull/282 got merged
(package! solarized-theme :recipe (:fetcher github :repo "wyuenho/solarized-emacs" :branch "diff-colors"))
