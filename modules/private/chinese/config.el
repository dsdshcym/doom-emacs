;;; private/ui/chinese/config.el -*- lexical-binding: t; -*-

(def-package! fcitx
  :after evil
  :config
  (fcitx-evil-turn-on))

(def-package! pangu-spacing
  :commands (global-pangu-spacing-mode pangu-spacing-mode)
  :init
  (global-pangu-spacing-mode 1)
  :config
  (setq pangu-spacing-real-insert-separtor t))

(def-package! ace-pinyin
  :after avy
  :config
  (ace-pinyin-global-mode t))
