;;; private/org/config.el -*- lexical-binding: t; -*-

(add-hook! org-mode #'doom|disable-line-numbers)

(def-package! org
  :config
  (add-hook 'org-mode-hook 'auto-fill-mode)

  (setq org-directory "~/Org")
  (setq org-default-notes-file "~/Org/refile.org")
  (setq org-publish-timestamp-directory (concat doom-cache-dir
                                                ".org-timestamps/")
        org-imenu-depth 9
        org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
          (sequence "READING(r)" "TOREVIEW(v!/!)" "|" "READ(R!/!)")
          (sequence "PENDING(p)" "|" "MERGED(m!/!)" "CANCELLED(c@/!)")
          (sequence "WAITING(w@/!)" "SOMEDAY(s@/!)" "|" "CANCELLED(c@/!)")))
  (setq org-return-follows-link t)

  (setq org-enforce-todo-dependencies nil)
  (setq org-yank-adjusted-subtrees t)
  (setq org-blank-before-new-entry '((heading . nil)
                                     (plain-list-item . nil)))

  (setq org-modules '(org-crypt
                      org-id
                      org-protocol))
  (eval-after-load 'org
    '(org-load-modules-maybe t))

  (setq org-indirect-buffer-display 'current-window)

  (setq org-cycle-level-after-item/entry-creation nil)

  ;; -----------------------------
  ;; Refile
  ;; -----------------------------
  (setq org-refile-targets '((+org/opened-buffer-files :maxlevel . 9)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-refile-use-cache t)
  (run-with-idle-timer 300 t (lambda ()
                               (org-refile-cache-clear)
                               (org-refile-get-targets)))

  (setq org-log-into-drawer "LOGBOOK")
  (setq org-log-reschedule 'note)
  (setq org-log-redeadline 'note)
  (setq org-log-done 'time)
  (setq org-log-note-headings
        '((done . "CLOSING NOTE %t")
          (state . "State %-12s from %-12S %t")
          (note . "Note taken on %t")
          (reschedule . "Rescheduled from %S to %s on %t")
          (delschedule . "Not scheduled, was %S on %t")
          (redeadline . "New deadline from %S to %s on %t")
          (deldeadline . "Removed deadline, was %S on %t")
          (refile . "Refiled on %t")
          (clock-out . "")))

  ;; -----------------------------
  ;; Tags
  ;; -----------------------------
  (setq org-tag-alist '((:startgroup)
                        ("@SCHOOL" . ?s)
                        ("@HOME" . ?h)
                        ("@WORK" . ?w)
                        (:endgroup)
                        ("TOWATCH" . ?W)
                        ("TOREAD" . ?R)))
  (setq org-tags-exclude-from-inheritance '("elfeed" "Book"))

  ;; -----------------------------
  ;; Archive
  ;; -----------------------------
  (setq org-archive-location (concat org-directory "/Archived/" "%s_archive::"))

  ;; -----------------------------
  ;; Link
  ;; -----------------------------
  (setq org-keep-stored-link-after-insertion t)

  (defadvice org-insert-link (before remove-nil-link-from-org-stored-links)
    "org-link-fontify-links-to-this-file cannot handle (nil \"\")"
    (setq org-stored-links
          (remove-if (lambda (x) (eq nil (car x))) org-stored-links)))

  (defadvice org-insert-link (before remove-dups-in-org-stored-links)
    (delete-dups org-stored-links)))

(def-package! org-attach
  :config
  (setq org-attach-directory (concat org-directory "/Attached/")))

(def-package! org-habit
  :config
  (setq org-habit-graph-column 50))

(def-package! org-info
  :commands (org-info))

(def-package! org-mac-link
  :commands (org-mac-safari-insert-frontmost-url
             org-mac-skim-insert-page
             org-mac-chrome-insert-frontmost-url))

(def-package! ob
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (shell . t)
     (emacs-lisp . t)
     (latex . t)
     (python . t)
     (ruby . t)
     (org . t)
     (sql . t)
     (C . t)
     (dot . t)
     (scheme . t)
     (plantuml . t)
     (ledger . t)
     (js . t)
     ))
  (setq org-export-babel-evaluate nil
        org-confirm-babel-evaluate nil))

(def-package! org-list
  :init
  (setq org-cycle-include-plain-lists 'integrate))

(def-package! org-id
  :init
  (setq org-id-locations-file (concat doom-cache-dir ".org-id-locations"))
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id))

(def-package! ox
  :config
  (setq org-export-coding-system 'utf-8)
  (setq org-export-backends '(beamer html latex md gfm))

  (setq org-export-with-sub-superscripts '{}
        org-export-with-section-numbers 3
        org-export-with-todo-keywords nil
        org-export-with-timestamps nil)

  ;; {{ export org-mode in Chinese into PDF
  ;; @see http://freizl.github.io/posts/2012-04-06-export-orgmode-file-in-Chinese.html
  (setq org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  ;; Use listings to export code blocks
  (setq org-latex-listings t)
  (setq org-latex-listings-options
        '(("breaklines" "")
          ("keywordstyle" "\\color{black}\\bfseries")
          ("basicstyle" "\\ttfamily\\scriptsize")))
  (add-to-list 'org-latex-packages-alist '("" "listings"))
  (add-to-list 'org-latex-packages-alist '("" "color"))

  ;; copy/pasted from spacemacs chinese layer
  (defadvice org-html-paragraph (before org-html-paragraph-advice
                                        (paragraph contents info) activate)
    "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
    (let* ((origin-contents (ad-get-arg 1))
           (fix-regexp "[[:multibyte:]]")
           (fixed-contents
            (replace-regexp-in-string
             (concat
              "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))
      (ad-set-arg 1 fixed-contents)))

  (setq org-html-mathjax-options
        (quote
         ((path "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_SVG")
          (scale "100")
          (align "center")
          (indent "2em")
          (mathml nil)))))

(def-package! org-clock
  :config
  (setq org-clock-mode-line-total 'current)
  ;; Show lot of clocking history so it's easy to pick items
  (setq org-clock-history-length 20)
  ;; Resume clocking task on clock-in if the clock is open
  (setq org-clock-in-resume t)
  ;; Change task state to STARTED when clocking in
  ;; (setq org-clock-in-switch-to-state 'bh/clock-in-to-next)

  ;; Save clock data and state changes and notes in the LOGBOOK drawer
  (setq org-clock-into-drawer t)
  ;; Removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)
  ;; Save the running clock and all clock history when exiting Emacs, load it on startup
  (setq org-clock-persist t)
  ;; Do not prompt to resume an active clock
  (setq org-clock-persist-query-resume nil)
  ;; Resume clocking task when emacs is restarted
  (org-clock-persistence-insinuate)
  (setq org-clock-persist-file (concat doom-cache-dir
                                       "org-clock-save.el"))
  ;; Clock out when moving task to a done state
  (setq org-clock-out-when-done t)
  ;; Enable auto clock resolution for finding open clocks
  (setq org-clock-auto-clock-resolution '(when-no-clock-is-running))
  ;; Include current clocking task in clock reports
  (setq org-clock-report-include-clocking-task t)
  (setq org-clock-clocktable-default-properties
        '(:link t :maxlevel 2 :scope file :narrow 70! :compact t))
  (setq org-clock-idle-time 10)

  (defun private/org-clock-cleanup ()
    (interactive)
    (private/join-separated-clock-lines)
    (private/add-clock-notation)
    (private/org-clock-update-time-in-buffer))

  (defun private/join-separated-clock-lines ()
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "\\(\\[.*\\]--\\)\n\\(\\[.*\\]\\)" nil t)
        (replace-match "\\1\\2"))))

  (defun private/add-clock-notation ()
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "^\\[.*\\]--\\[.*\\]$" nil t)
        (replace-match "CLOCK: \\&"))))

  (defun private/org-clock-update-time-in-buffer ()
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "CLOCK: \\[.*\\]--\\[.*\\]" nil t)
        (org-clock-update-time-maybe)))))

(def-package! org-agenda
  :commands (org-agenda-list
             org-agenda
             org-agenda-to-appt)
  :config
  (setq org-agenda-diary-file "~/Org/journal.org")
  (setq org-agenda-files '("~/Org" "~/Org/notes"  "~/Org/lists"))

  ;; Overwrite the current window with the agenda
  (setq org-agenda-window-setup 'current-window)

  (setq org-agenda-restore-windows-after-quit t)

  (setq org-agenda-span 'day)

  (setq org-agenda-clockreport-parameter-plist
        '(:link t :maxlevel 9 :fileskip0 t :narrow 70! :formula "$4=$3*(60/25);t" :compact t))

  (setq org-agenda-custom-commands
        '(("h" "Agenda and Home-related tasks"
           ((agenda "")
            (tags-todo "@HOME")))
          ("w" "@WORK"
           ((agenda ""))
           ((org-agenda-tag-filter-preset '("+@WORK"))))))

  (setq org-agenda-skip-scheduled-if-deadline-is-shown 'not-today)
  (evil-set-initial-state 'org-agenda-mode 'normal)

  (run-at-time "24:01" 3600 '+org/org-agenda-refresh-appt))

(def-package! appt
  :config
  (defun private/macos-do-not-display-is-on? ()
    (string-prefix-p "1"
                     (shell-command-to-string
                      "defaults read ~/Library/Preferences/ByHost/com.apple.notificationcenterui.plist doNotDisturb")))

  (defun private/appt-display (min-to-app new-time msg)
    (if (private/macos-do-not-display-is-on?)
        (appt-disp-window min-to-app new-time msg)
      (private/notification "Org Agenda Appointment" msg (format "Appointment in %s minute(s)" min-to-app) "1")))

  (setq appt-disp-window-function 'private/appt-display))

(def-package! org-capture
  :commands (org-capture)
  :config
  (setq org-capture-templates
        '(("t" "Todo Later" entry
           (file+headline "~/Org/refile.org" "Todo Later")
           (function +org/capture-template)
           :content-before "* TODO %?")
          ("w" "Watch Later" entry
           (file+headline "~/Org/refile.org" "Watch Later")
           (function +org/capture-template)
           :content-before "* TODO %a"
           :immediate-finish t)
          ("r" "Read Later" entry
           (file+headline "~/Org/refile.org" "Read Later")
           (function +org/capture-template)
           :content-before "* TODO %a"
           :immediate-finish t)
          ("b" "Blog Thought" entry
           (file+headline "~/Org/blogs.org" "Blog")
           (function +org/capture-template)
           :content-before "* TODO %^{Title}"
           :immediate-finish t)
          ("T" "Clock-in Task" entry
           (file "~/Org/refile.org")
           (function +org/capture-template)
           :content-before "* TODO %^{prompt}"
           :clock-in t
           :clock-resume t)
          ("i" "Interruption" entry
           (file+headline "~/Org/refile.org" "Todo Later")
           (function +org/capture-template)
           :content-before "* TODO %^{Task}\nSCHEDULED: %t"
           :immediate-finish t)
          ("l" "Link to current file" entry
           (file "~/Org/refile.org")
           (function +org/capture-template)
           :content-before "* TODO %a")
          ("L" "(Clocked in) Link to current file" entry
           (file "~/Org/refile.org")
           (function +org/capture-template)
           :content-before "* TODO %a"
           :clock-in t
           :clock-resume t)
          ("c" "Link under current clock" entry
           (clock)
           (function +org/capture-template)
           :content-before "* TODO %a")
          ("C" "(Clocked-in) Link under current clock" entry
           (clock)
           (function +org/capture-template)
           :content-before "* TODO %a"
           :clock-in t
           :clock-resume t)
          ("k" "Push to Kindle" entry
           (file+headline "~/Org/refile.org" "Push to Kindle")
           (function +org/capture-template)
           :content-before "* TODO %a %(private/push-to-kindle \"%l\")"
           :immediate-finish t)
          ("p" "Github PR" entry
           (clock)
           (function +org/capture-template)
           :content-before "* PENDING %a"
           :immediate-finish t)
          ("d" "Daily Review" entry
           (file+headline "~/Org/review.org" "Daily Review")
           (function +org/capture-template)
           :content-before "* NEXT Review %u"
           :content-after "- Amazing things that happened today\n  1. %?\n- How could today have been even better?\n  1. "
           :clock-in t)
          ("D" "Daily Report at Ekohe" plain
           (file+headline "~/Org/ekohe.org" "Daily Report")
           "- %u\n  + Yesterday%?\n  + Today"))))

(def-package! org-indent
  :init (setq org-startup-indented t))

(def-package! org-expiry
  :config
  (setq org-expiry-inactive-timestamps t)
  (org-expiry-insinuate))

(def-package! evil-org
  :commands (evil-org-mode
             evil-org-set-key-theme)
  :init
  (setq evil-org-special-o/O nil)
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme))))

(def-package! org-pomodoro
  :commands (org-pomodoro))

;; (def-package! org-tree-slide
;;   :commands 'org-tree-slide-mode
;;   :config
;;   (org-tree-slide-simple-profile)
;;   :general
;;   (private/set-leader-keys-for-mode
;;    :keymaps '(org-mode-map org-tree-slide-mode-map)
;;    "Ss" 'org-tree-slide-mode
;;    "Sn" 'org-tree-slide-move-next-tree
;;    "Sp" 'org-tree-slide-move-previous-tree
;;    "Sc" 'org-tree-slide-content))

;; (def-package! ox-reveal
;;   :after ox
;;   :config
;;   (setq org-reveal-root "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.5.0/"))

(def-package! ox-md
  :after ox)

(def-package! ox-gfm
  :after ox)

(def-package! org-drill
  :commands (org-drill))

(def-package! org-mime
  :commands (org-mime-htmlize org-mime-org-buffer-htmlize))

(def-package! org-download
  :config
  (progn
    (setq org-download-method 'attach)
    (setq org-download-screenshot-method "screencapture -i %s")))

(load! +bindings)
