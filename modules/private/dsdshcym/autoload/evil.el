;; private/dsdshcym/autoload/evil.el -*- lexical-binding: t; -*-
;;;###if (featurep! :feature evil)

;;;###autoload (autoload '+dsdshcym:cd "private/dsdshcym/autoload/evil" nil t)
(evil-define-command +dsdshcym:cd ()
  "Change `dsdshcym-directory' with `cd'."
  (interactive "<f>")
  (cd input))

;;;###autoload (autoload '+dsdshcym:kill-all-buffers "private/dsdshcym/autoload/evil" nil t)
(evil-define-command +dsdshcym:kill-all-buffers (&optional bang)
  "Kill all buffers. If BANG, kill current session too."
  (interactive "<!>")
  (if bang
      (+workspace/kill-session)
    (doom/kill-all-buffers)))

;;;###autoload (autoload '+dsdshcym:kill-matching-buffers "private/dsdshcym/autoload/evil" nil t)
(evil-define-command +dsdshcym:kill-matching-buffers (&optional bang pattern)
  "Kill all buffers matching PATTERN regexp. If BANG, only match project
buffers."
  (interactive "<a>")
  (doom/kill-matching-buffers pattern bang))

;;;###autoload
(defun +dsdshcym:evil-complete (arg)
  "Expand wih company mode if available, otherwise hippie-expand."
  (interactive)
  (unless (company-complete)
    (hippie-expand arg)))
