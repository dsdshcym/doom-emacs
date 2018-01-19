;;; private/mu4e/config.el -*- lexical-binding: t; -*-

(def-package! mu4e
  :commands (mu4e mu4e-compose-new)
  :init
  (setq url-mail-command 'mu4e-compose-new)
  :config
  (setq mu4e-completing-read-function 'completing-read)
  (setq mu4e-confirm-quit nil)

  ;; default
  (setq mu4e-maildir (expand-file-name "~/Maildir"))

  (setq mu4e-refile-folder "/gmail/all mail")
  (setq mu4e-drafts-folder "/gmail/drafts")
  (setq mu4e-sent-folder   "/gmail/sent")
  (setq mu4e-trash-folder  "/gmail/trash")

  ;;rename files when moving
  ;;NEEDED FOR MBSYNC
  (setq mu4e-change-filenames-when-moving t)

  ;; don't save message to Sent Messages, GMail/IMAP will take care of this
  (setq mu4e-sent-messages-behavior 'delete)

  (setq mu4e-update-interval 1800)

  (setq mu4e-html2text-command "pandoc -f html -t org")

  ;; setup some handy shortcuts
  (setq mu4e-maildir-shortcuts
        '(("/gmail/inbox"    . ?i)
          ("/gmail/sent"     . ?s)
          ("/gmail/trash"    . ?t)
          ("/gmail/all mail" . ?a)
          ("/ekohe/inbox"    . ?w)))

  (setq mu4e-bookmarks
        '(
          ("flag:unread AND NOT flag:trashed AND NOT maildir:\"/gmail/all mail\" AND NOT maildir:\"/ekohe/all mail\""
           "Unread messages"  ?u)
          ("date:today..now AND NOT maildir:\"/gmail/all mail\" AND NOT maildir:\"/ekohe/all mail\""
           "Today's messages" ?t)
          ("date:7d..now AND NOT maildir:\"/gmail/all mail\" AND NOT maildir:\"/ekohe/all mail\""
           "Last 7 days"      ?w)
          )
        )

  (setq mu4e-get-mail-command "mbsync -a")

  (setq mu4e-attachment-dir "~/Downloads")

  (setq mu4e-view-prefer-html nil)

  ;; Store link to message if in header view, not to header query
  (setq org-mu4e-link-query-in-headers-mode nil)

  (setq mu4e-org-contacts-file (expand-file-name "~/Org/contacts.org"))
  (eval-after-load 'mu4e-headers
    (lambda ()
      (add-to-list 'mu4e-headers-actions
                   '("org-contact-add" . mu4e-action-add-org-contact) t)))
  (eval-after-load 'mu4e-view
    (lambda ()
      (add-to-list 'mu4e-view-actions
                   '("org-contact-add" . mu4e-action-add-org-contact) t)))

  (setq message-send-mail-function 'smtpmail-send-it
        starttls-use-gnutls t
        smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
        smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg")
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587)

  (defvar my-mu4e-account-alist
    '(("gmail"
       (mu4e-sent-folder   "/gmail/sent")
       (mu4e-drafts-folder "/gmail/drafts")
       (smtpmail-default-smtp-server "smtp.gmail.com")
       (smtpmail-smtp-user "dsdshcym")
       (smtpmail-smtp-server "smtp.gmail.com")
       ;; (smtpmail-stream-type starttls)
       (smtpmail-smtp-service 587))
      ("ekohe"
       (mu4e-sent-folder   "/ekohe/sent")
       (mu4e-drafts-folder "/ekohe/drafts")
       (user-mail-address "yiming@ekohe.com")
       (smtpmail-default-smtp-server "smtp.gmail.com")
       (smtpmail-smtp-user "yiming@ekohe.com")
       (smtpmail-smtp-server "smtp.gmail.com")
       ;; (smtpmail-stream-type starttls)
       (smtpmail-smtp-service 587))
      ))

  (defun my-mu4e-set-account ()
    "Set the account for composing a message."
    (let* ((account
            (if mu4e-compose-parent-message
                (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                  (string-match "/\\(.*?\\)/" maildir)
                  (match-string 1 maildir))
              (completing-read (format "Compose with account: (%s) "
                                       (mapconcat #'(lambda (var) (car var))
                                                  my-mu4e-account-alist "/"))
                               (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                               nil t nil nil (caar my-mu4e-account-alist))))
           (account-vars (cdr (assoc account my-mu4e-account-alist))))
      (if account-vars
          (mapc #'(lambda (var)
                    (set (car var) (cadr var)))
                account-vars)
        (error "No email account found"))))

  (add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

  (add-to-list 'mu4e-view-actions
               '("browser" . mu4e-action-view-in-browser)))

(def-package! evil-mu4e
  :after mu4e)

(def-package! mu4e-maildirs-extension
  :after mu4e
  :config (mu4e-maildirs-extension-load))

(def-package! org-mu4e
  :after mu4e
  :config
  (setq org-mu4e-link-query-in-headers-mode nil
        org-mu4e-convert-to-html t)

  ;; Only render to html once. If the first send fails for whatever reason,
  ;; org-mu4e would do so each time you try again.
  (add-hook! 'message-send-hook
    (setq-local org-mu4e-convert-to-html nil)))
