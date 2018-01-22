;;; tools/macos/config.el -*- lexical-binding: t; -*-

(when (eq window-system 'mac)
  (setq mac-pass-command-to-system nil)
  (mac-auto-operator-composition-mode t))

(def-package! dash-at-point
  :commands (dash-at-point dash-at-point-with-docset))

(def-package! osx-dictionary
  :commands (osx-dictionary-search-pointer
             osx-dictionary-search-input
             osx-dictionary-cli-find-or-recompile))
