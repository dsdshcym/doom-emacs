;; -*- no-byte-compile: t; -*-
;;; feature/version-control/packages.el

;;; config.el
;; n/a

;;; +git
(unless (featurep! -git)
  (package! git-gutter-fringe)
  (package! git-link)
  (package! git-timemachine)
  (package! gitconfig-mode)
  (package! gitignore-mode)
  (package! magit)
  (package! orgit)
  (when (featurep! :feature evil)
    (package! evil-magit)))

;;; TODO +hg
