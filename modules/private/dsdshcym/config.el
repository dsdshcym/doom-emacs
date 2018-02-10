;;; private/default/config.el -*- lexical-binding: t; -*-

(load! +bindings)
(load! +evil-commands)

;;
;; Config
;;

(after! ivy
  (setq ivy-use-virtual-buffers t)
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(after! undo-tree
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-diff t)
  (set! :popup "^ ?\\*undo-tree\*" :ignore))

(after! magit
  (setq magit-repository-directories '(("~/Projects/" . 2))))

(after! magithub
  (setq magithub-clone-default-directory "~/Projects/"))

(after! ledger
  (set! :popup "\\*Ledger" '((side . right) (size . 0.5))))

(after! flyspell
  (add-hook! '(org-mode-hook text-mode-hook) #'flyspell-mode)
  (add-hook! 'prog-mode-hook #'flyspell-prog-mode)
  (setq ispell-program-name "hunspell"
        ispell-dictionary "en_US"
        ispell-local-dictionary-alist '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US,en_US-med") nil utf-8)))
  (map! :map flyspell-mode-map
        :ni "C-;" #'flyspell-correct-previous-word-generic))

(after! epa
  (setq epa-file-encrypt-to (or epa-file-encrypt-to user-mail-address)
        ;; With GPG 2.1, this forces gpg-agent to use the Emacs minibuffer to
        ;; prompt for the key passphrase.
        epa-pinentry-mode 'loopback))

(after! smartparens
  (dolist (brace '("(" "{" "["))
    (sp-pair brace nil :post-handlers '(:add ("||\n[i]" "RET")))))

(after! evil
  (setq-default evil-shift-width 2)

  (setq evil-want-visual-char-semi-exclusive nil)
  (setq evil-ex-substitute-global nil)
  (setq evil-complete-next-func '+dsdshcym:evil-complete)

  (evil-define-motion evil-goto-line (count)
    "Go to the first non-blank character of line COUNT.
By default the (truly) last line."
    :jump t
    :type line
    (if (null count)
        (goto-char (buffer-size))
      (goto-char (point-min))
      (forward-line (1- count)))
    (evil-first-non-blank)))
