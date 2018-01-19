;;; private/org/autoload/org.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +org/opened-buffer-files ()
  "Return the list of files currently opened in emacs"
  (delq nil
        (mapcar (lambda (x)
                  (if (and (buffer-file-name x)
                           (string-match "\\.org$"
                                         (buffer-file-name x)))
                      (buffer-file-name x)))
                (buffer-list))))

;;;###autoload
(defun +org/org-clock-cleanup ()
  (interactive)
  (+org/join-separated-clock-lines)
  (+org/add-clock-notation)
  (+org/org-clock-update-time-in-buffer))

;;;###autoload
(defun +org/join-separated-clock-lines ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\(\\[.*\\]--\\)\n\\(\\[.*\\]\\)" nil t)
      (replace-match "\\1\\2"))))

;;;###autoload
(defun +org/add-clock-notation ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^\\[.*\\]--\\[.*\\]$" nil t)
      (replace-match "CLOCK: \\&"))))

;;;###autoload
(defun +org/org-clock-update-time-in-buffer ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "CLOCK: \\[.*\\]--\\[.*\\]" nil t)
      (org-clock-update-time-maybe))))

;;;###autoload
(defun +org/org-agenda-refresh-appt ()
  (interactive)
  (org-agenda-to-appt t))

;;;###autoload
(defun +org/macos-do-not-display-is-on? ()
  (string-prefix-p "1"
                   (shell-command-to-string
                    "defaults read ~/Library/Preferences/ByHost/com.apple.notificationcenterui.plist doNotDisturb")))

;;;###autoload
(defun +org/appt-display (min-to-app new-time msg)
  (if (+org/macos-do-not-display-is-on?)
      (appt-disp-window min-to-app new-time msg)
    (+org/notification "Org Agenda Appointment" msg (format "Appointment in %s minute(s)" min-to-app) "1")))

;;;###autoload
(defun +org/link-to-org-tags (url)
  (cond
   ((not url) "")
   ((string-match-p "twitter"       url) " :Twitter:")
   ((string-match-p "solidot"       url) " :Solidot:")
   ((string-match-p "mu4e"          url) " :Email:")
   ((string-match-p "v2ex"          url) " :V2EX:")
   ((string-match-p "waerfa"        url) " :玩儿法:")
   ((string-match-p "wanqu.co"      url) " :Wanqu:")
   ((string-match-p "youtube"       url) " :YouTube:")
   ((string-match-p "bilibili"      url) " :Bilibili:")
   ((string-match-p "zhihu"         url) " :Zhihu:")
   ((string-match-p "sspai"         url) " :少数派:")
   ((string-match-p "weixin.qq.com" url) " :WeChat:")))

;;;###autoload
(defun +org/capture-template ()
  (let ((link-to-org-tags "%(+org/link-to-org-tags \"%l\")")
        (properties "\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        (content-before (plist-get org-capture-plist :content-before))
        (content-after (plist-get org-capture-plist :content-after)))
    (concat content-before link-to-org-tags properties content-after)))
