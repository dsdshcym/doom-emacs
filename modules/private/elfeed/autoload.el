;;; private/elfeed/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +elfeed/org-elfeed-entry-store-link ()
    (interactive)
    (when (and (boundp 'elfeed-show-entry) elfeed-show-entry)
      (let* ((link (elfeed-entry-link elfeed-show-entry))
             (title (elfeed-entry-title elfeed-show-entry)))
        (message title)
        (org-store-link-props
         :link link
         :description title)
        )))
