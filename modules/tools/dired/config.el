;;; tools/dired/config.el -*- lexical-binding: t; -*-

(setq ;; Always copy/delete recursively
      dired-recursive-copies  'always
      dired-recursive-deletes 'top
      dired-dwim-target t
      ;; Auto refresh dired, but be quiet about it
      global-auto-revert-non-file-buffers t
      auto-revert-verbose nil
      ;; files
      image-dired-dir (concat doom-cache-dir "image-dired/")
      image-dired-db-file (concat image-dired-dir "image-dired/db.el")
      image-dired-gallery-dir (concat image-dired-dir "gallery/")
      image-dired-temp-image-file (concat image-dired-dir "temp-image")
      image-dired-temp-rotate-image-file (concat image-dired-dir "temp-rotate-image"))

(defun +dired|sort-directories-first ()
  "List directories first in dired buffers."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))
(add-hook 'dired-after-readin-hook #'+dired|sort-directories-first)

;; Automatically create missing directories when creating new files
(defun +dired|create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))
(push #'+dired|create-non-existent-directory find-file-not-found-functions)

;;
;; Packages
;;

(after! dired
  (map! :map dired-mode-map
        doom-leader-key nil))

(def-package! wdired
  :after dired)

(def-package! dired-quick-sort
  :after dired
  :config
  (dired-quick-sort-setup))
