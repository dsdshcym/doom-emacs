;;; private/ui/config.el -*- lexical-binding: t; -*-

(remove-hook 'doom-post-init-hook #'blink-cursor-mode)
(remove-hook 'doom-init-ui-hook #'blink-cursor-mode)
(blink-cursor-mode -1)
(setq frame-resize-pixelwise t)
(setq-default frame-title-format "%b")

;; (after! doom-themes-org
;;   (remove-hook 'org-font-lock-set-keywords-hook #'doom-org-custom-fontification))

;; (add-hook 'doom-init-theme-hook
;;           (λ!
;;            (set-face-attribute 'org-level-1 nil :height 1.0)
;;            (setq-default
;;             org-fontify-done-headline nil
;;             org-fontify-quote-and-verse-blocks nil
;;             org-fontify-whole-heading-line nil)))

(setq doom-line-numbers-style 'relative)

(def-package! solarized-theme
  :config
  (setq solarized-use-variable-pitch nil)
  (setq solarized-scale-org-headlines nil)
  (setq doom-theme 'solarized-dark))

;; NOTE Adjust these bitmaps if you change `doom-fringe-size'
(after! flycheck
  ;; because git-gutter is in the left fringe
  (setq flycheck-indication-mode 'right-fringe)
  ;; A non-descript, left-pointing arrow
  (fringe-helper-define 'flycheck-fringe-bitmap-double-arrow 'center
    "...X...."
    "..XX...."
    ".XXX...."
    "XXXX...."
    ".XXX...."
    "..XX...."
    "...X...."))

;; subtle diff indicators in the fringe
(after! git-gutter-fringe
  ;; places the git gutter outside the margins.
  (setq-default fringes-outside-margins t)
  ;; thin fringe bitmaps
  (fringe-helper-define 'git-gutter-fr:added '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:deleted 'bottom
    "X......."
    "XX......"
    "XXX....."
    "XXXX...."))
