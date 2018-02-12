;;; private/org/+bindings.el -*- lexical-binding: t; -*-

(map!
 (:after org
   :map org-mode-map
   :n "<return>" #'org-open-at-point)

 (:after evil-org
   :map org-mode-map
   :n "C-<return>" #'org-insert-heading-respect-content
   :n "C-S-<return>" #'org-insert-todo-heading-respect-content
   :n "M-<return>" (evil-org-define-eol-command org-meta-return)
   :n "M-S-<return>" (evil-org-define-eol-command org-insert-todo-heading))

 (:after org-agenda
   :map org-agenda-keymap
   :n "<tab>" 'org-agenda-switch-to
   :n "<return>" 'org-agenda-switch-to
   :n "i" 'org-agenda-clock-in
   :n "s" 'org-agenda-schedule
   :n "d" 'org-agenda-deadline
   :n "t" 'org-agenda-todo
   :n "j" 'org-agenda-next-line
   :n "k" 'org-agenda-previous-line
   :n "L" 'org-agenda-log-mode
   :n "q" 'org-agenda-quit
   :n "f" 'org-agenda-later
   :n "b" 'org-agenda-earlier
   :n "gr" 'org-agenda-redo
   :n "R" 'org-agenda-clockreport-mode
   :n "gj" 'org-agenda-next-line
   :n "gk" 'org-agenda-previous-line)

 (:after org
   (:localleader
     :map org-mode-map
     :n "cc" #'org-clock-cancel
     :n "ci" #'org-clock-in
     :n "co" #'org-clock-out
     :n "cr" #'org-resolve-clocks
     :n "dd" #'org-deadline
     :n "ds" #'org-schedule
     :n "dt" #'org-time-stamp
     :n "dT" #'org-time-stamp-inactive

     :n "e" #'org-export-dispatch

     :n "a" #'org-agenda

     :n "p" #'org-rich-yank

     :n "t" #'org-todo

     ;; More cycling options (timestamps, headlines, items, properties)
     :n "L" #'org-shiftright
     :n "H" #'org-shiftleft
     :n "J" #'org-shiftdown
     :n "K" #'org-shiftup

     ;; Change between TODO sets
     :n "C-S-l" #'org-shiftcontrolright
     :n "C-S-h" #'org-shiftcontrolleft
     :n "C-S-j" #'org-shiftcontroldown
     :n "C-S-k" #'org-shiftcontrolup

     ;; Subtree editing
     :n "sa" #'org-archive-subtree
     :n "sb" (lambda () (interactive) (org-tree-to-indirect-buffer 4))
     :n "sh" #'org-promote-subtree
     :n "sj" #'org-move-subtree-down
     :n "sk" #'org-move-subtree-up
     :n "sl" #'org-demote-subtree
     :n "sn" #'org-narrow-to-subtree
     :n "sN" #'widen
     :n "sr" #'org-refile
     :n "ss" #'org-sparse-tree
     :n "sS" #'org-sort

     ;; Multi-purpose keys
     :n "'"        #'org-ctrl-c-ctrl-c
     :n "*"        #'org-ctrl-c-star
     :n "<return>" #'org-ctrl-c-ret
     :n "-"        #'org-ctrl-c-minus
     :n "#"        #'org-update-statistics-cookies
     ;; attachments
     :n "A"        #'org-attach
     ;; insertion
     :n "id"       #'org-insert-drawer
     :n "ie"       #'org-set-effort
     :n "if"       #'org-footnote-new
     :n "ih"       #'org-insert-heading
     :n "iH"       #'org-insert-heading-after-current
     :n "il"       #'org-insert-link
     :n "ip"       #'org-set-property
     :n "is"       #'org-insert-subheading
     :n "it"       #'org-set-tags)))
