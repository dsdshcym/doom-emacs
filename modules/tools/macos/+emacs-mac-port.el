;;; tools/macos/+emacs-mac-port.el -*- lexical-binding: t; -*-

(setq mouse-highlight nil)
(setq mac-pass-command-to-system nil)
(mac-auto-operator-composition-mode t)

(def-package! mac-win
  :config
  (setq mac-frame-tabbing nil)

  (defun +mac-new-tab ()
    "Create a new tab on mac"
    (interactive)
    (let ((mac-frame-tabbing t))
      (new-frame)))

  (defun +mac-kill-tab ()
    "Kill a tab (Just an alias for delete-frame since a tab on
mac is actually just a frame)"
    (interactive)
    (delete-frame))

  (map!
   :n "gt" 'mac-next-tab
   :n "gT" 'mac-previous-tab))
