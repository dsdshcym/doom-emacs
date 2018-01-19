;;; private/org-page/config.el -*- lexical-binding: t; -*-

(use-package org-page
  :config
  (setq op/repository-directory "~/Projects/dsdshcym.github.io/"
        op/site-domain "http://dsdshcym.github.io"
        op/personal-github-link "https://github.com/dsdshcym"
        op/site-main-title "dsdshome"
        op/site-sub-title "This is my small blog :)"
        op/personal-disqus-shortname "dsdshcym-github-io"
        op/theme-root-directory (expand-file-name "~/Projects/doom-emacs/modules/private/org-page/org-page-themes")
        op/theme 'wy))

(defun org-page/do-publication ()
  (interactive)
  (op/do-publication))

(defun org-page/new-post (&optional category default-tags)
  (interactive)
  (let* ((category (or category "blog"))
         (title (read-string "Title: "))
         (keywords (read-string "Keywords: "))
         (tags (read-string "Tags: " default-tags))
         (underscore-title (replace-regexp-in-string "[[:space:]]+" "_" title))
         (kebab-title (s-dashed-words underscore-title))
         (filename (concat kebab-title ".org"))
         (dir (concat (file-name-as-directory op/repository-directory)
                      (file-name-as-directory category)))
         (path (concat dir filename)))
    (op/git-change-branch op/repository-directory op/repository-org-branch)
    (if (file-exists-p path)
        (error "Post `%s' already exists." path))
    (unless (file-directory-p dir)
      (mkdir dir t))
    (switch-to-buffer (find-file path))
    (op/insert-options-template title
                                (concat "/" category "/%y/%m/%d/" kebab-title)
                                keywords
                                tags)
    (save-buffer)))

(defun org-page/new-blog ()
  (interactive)
  (org-page/new-post "blog"))

(defun org-page/new-clipping ()
  (interactive)
  (org-page/new-post "clipping" "Clipping, "))
