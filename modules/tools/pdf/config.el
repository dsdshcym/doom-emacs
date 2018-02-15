;;; tools/pdf/config.el -*- lexical-binding: t; -*-

(def-package! pdf-tools
  :defer t
  :init (load "pdf-tools-autoloads.el" nil t t)
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  ;; turn off cua so copy works
  (add-hook! 'pdf-view-mode-hook (cua-mode 0)))


(when (featurep! :lang latex)
  (after! latex
    ;; add to the program list
    (add-to-list 'TeX-view-program-selection
                 '(output-pdf "PDF Tools"))
    (add-to-list 'TeX-view-program-list
                 '("PDF Tools" ("TeX-pdf-tools-sync-view")))

    ;; enable document revert
    (add-hook 'TeX-after-compilation-finished-functions
              #'TeX-revert-document-buffer)

    ;; correlated mode
    (setq TeX-source-correlate-start-server t
          TeX-source-correlate-mode t)))
