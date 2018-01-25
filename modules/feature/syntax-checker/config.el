;;; feature/syntax-checker/config.el -*- lexical-binding: t; -*-

;; Since Doom doesn't use `package-initialize', pkg-info won't get autoloaded
;; when `flycheck-version' needs it, so we need this:
(autoload 'pkg-info-version-info "pkg-info")

(def-package! flycheck
  :commands (flycheck-mode flycheck-list-errors flycheck-buffer)
  :config
  ;; Emacs feels snappier without checks on newline
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled))

  (after! evil
    (defun +syntax-checkers|flycheck-buffer ()
      "Flycheck buffer on ESC in normal mode."
      (when flycheck-mode
        (ignore-errors (flycheck-buffer))
        nil))
    (add-hook 'doom-escape-hook #'+syntax-checkers|flycheck-buffer t)

    ;; With the option of flychecking the buffer on escape, so we don't need
    ;; auto-flychecking on idle-change:
    (delq 'idle-change flycheck-check-syntax-automatically))

  ;; NOTE Adjust these bitmaps if you change `doom-fringe-size'
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
