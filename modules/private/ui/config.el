;;; private/ui/config.el -*- lexical-binding: t; -*-

(remove-hook 'doom-post-init-hook #'blink-cursor-mode)
(remove-hook 'doom-init-ui-hook #'blink-cursor-mode)
(blink-cursor-mode -1)
(setq frame-resize-pixelwise t)
(setq-default frame-title-format "%b")

(defun private/set-monospaced-font (english chinese english-size)
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" english english-size))
  (set-frame-font english)
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family chinese))))

(add-hook 'doom-init-theme-hook
          (λ! (private/set-monospaced-font "Iosevka" "PingFang SC" 14)))

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

(after! evil
  (defun +evil*init-cursors (&rest _)
    (setq evil-normal-state-cursor '(box "DarkGoldenrod2")
          evil-insert-state-cursor '((bar . 2) "chartreuse3")
          evil-emacs-state-cursor '(box "SkyBlue2")
          evil-replace-state-cursor '((hbar . 2) "chocolate")
          evil-visual-state-cursor '((hbar . 2) "gray")
          evil-motion-state-cursor '(box "plum3"))))

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
