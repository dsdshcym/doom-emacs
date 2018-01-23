;;; private/elfeed/config.el -*- lexical-binding: t; -*-

(def-package! elfeed
  :commands elfeed
  :config
  (org-link-set-parameters "elfeed" :store #'+elfeed/org-elfeed-entry-store-link)
  (map!
   (:map elfeed-search-mode-map
     :n "RET" #'elfeed-search-show-entry
     :n "s"   #'elfeed-search-live-filter
     :n "b"   #'elfeed-search-browse-url
     :n "c"   #'elfeed-db-compact
     :n "r"   #'elfeed-search-untag-all-unread
     :n "u"   #'elfeed-search-tag-all-unread
     :n "y"   #'elfeed-search-yank
     :n "gr"  #'elfeed-update
     :n "gR"  #'elfeed-search-update--force
     :n "gu"  #'elfeed-unjam
     :n "q"   #'quit-window)
   (:map elfeed-show-mode-map
     :n "C-n" #'elfeed-show-next
     :n "C-p" #'elfeed-show-prev
     :n "y"   #'elfeed-show-yank
     :n "b"   #'elfeed-show-visit
     :n "q"   #'elfeed-kill-buffer)))

(def-package! elfeed-org
  :after elfeed
  :init
  (setq rmh-elfeed-org-files '("~/Org/rss_feed.org"))
  :config
  (elfeed-org)
  (defun rmh-elfeed-org-convert-tree-to-headlines (parsed-org)
    (org-element-map parsed-org 'headline
      (lambda (h)
        (let* ((heading (org-element-property :raw-value h))
               (tags (mapcar 'intern (org-element-property :tags h))))
          (-concat (list heading) tags)))))

  (defun rmh-elfeed-org-filter-relevant (list)
    "Filter relevant entries from the LIST."
    (-filter
     (lambda (entry)
       (and
        (string-match "\\(http\\|entry-title\\)" (car entry))
        (member (intern rmh-elfeed-org-tree-id) entry)
        (not (member (intern rmh-elfeed-org-ignore-tag) entry))))
     list)))
