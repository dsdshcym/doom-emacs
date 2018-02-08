;;; ui/doom/config.el -*- lexical-binding: t; -*-

;; <https://github.com/hlissner/emacs-doom-theme>
(def-package! doom-themes
  :config
  (unless doom-theme
    (setq doom-theme 'doom-one)
    (after! solaire-mode
      (add-hook 'doom-init-theme-hook #'solaire-mode-swap-bg t)))

  ;; Ensure `doom/reload-load-path' reloads common faces
  (defun +doom|reload-theme () (load "doom-themes-common.el" nil t))
  (add-hook 'doom-pre-reload-theme-hook #'+doom|reload-theme)

  ;; improve integration w/ org-mode
  (add-hook 'doom-init-theme-hook #'doom-themes-org-config)

  ;; more Atom-esque file icons for neotree
  (add-hook 'doom-init-theme-hook #'doom-themes-neotree-config)
  (setq doom-neotree-enable-variable-pitch t
        doom-neotree-file-icons 'simple
        doom-neotree-line-spacing 2))


(def-package! solaire-mode
  :hook (after-change-major-mode . turn-on-solaire-mode)
  :config
  (setq solaire-mode-real-buffer-fn #'doom-real-buffer-p)
  ;; Prevent color glitches when reloading either DOOM or the theme
  (add-hook! '(doom-init-theme-hook doom-reload-hook)
    #'solaire-mode-reset)
  ;; org-capture takes an org buffer and narrows it. The result is erroneously
  ;; considered an unreal buffer, so solaire-mode must be restored.
  (add-hook 'org-capture-mode-hook #'turn-on-solaire-mode))


(after! hideshow
  (defface +doom-folded-face
    `((((background dark))
       (:inherit font-lock-comment-face :background ,(doom-color 'base0)))
      (((background light))
       (:inherit font-lock-comment-face :background ,(doom-color 'base3))))
    "Face to hightlight `hideshow' overlays."
    :group 'doom)

  ;; Nicer code-folding overlays (with fringe indicators)
  (defun +doom-set-up-overlay (ov)
    (when (eq 'code (overlay-get ov 'hs))
      (when (featurep 'vimish-fold)
        (overlay-put
         ov 'before-string
         (propertize "…" 'display
                     (list vimish-fold-indication-mode
                           'empty-line
                           'vimish-fold-fringe))))
      (overlay-put
       ov 'display (propertize "  [...]  " 'face '+doom-folded-face))))
  (setq hs-set-up-overlay #'+doom-set-up-overlay))
