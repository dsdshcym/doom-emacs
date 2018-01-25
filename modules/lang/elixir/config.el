;;; lang/elixir/config.el -*- lexical-binding: t; -*-

(def-package! elixir-mode
  :mode "\\.exs?$"
  :mode "\\.elixir2$"
  :config
  (set! :electric 'elixir-mode :words '("else" "end")))


(def-package! ob-elixir
  :after org
  :init
  (add-to-list 'org-babel-load-languages '(elixir . t)))


(def-package! smartparens-elixir
  :config
  ;; disable standard config; more disruptive than it needs to be
  (dolist (beg '("fn" "do" "def" "defp" "defmodule" "if" "unless" "case" "receive"))
    (sp-local-pair 'elixir-mode beg nil :actions :rem))
  ;; only complete the basics
  (sp-with-modes 'elixir-mode
    (sp-local-pair "do" "end" :when '(("RET" "<evil-ret>")) :post-handlers '("||\n[i]"))
    (sp-local-pair "do " " end")
    (sp-local-pair "fn " " end")))


(def-package! alchemist
  :after elixir-mode
  :hook (elixir-mode . alchemist-mode)
  :config
  (set! :popup "^\\*alchemist elixir"
     '((size . 0.35)) '((transient . 0) (select . ignore)))
  (set! :popup "^\\*alchemist test"
     '((size . 0.35)) '((transient . 0) (select . ignore)))
  (set! :repl 'elixir-mode #'alchemist-iex-run)
  (set! :lookup 'elixir-mode
    :definition #'alchemist-goto-definition-at-point
    :documentation #'alchemist-help-search-at-point)
  (set! :eval 'elixir-mode #'alchemist-eval-region))


(def-package! alchemist-company
  :when (featurep! :completion company)
  :after elixir-mode
  :config
  ;; Let Doom handle this
  (let ((fn (byte-compile (lambda () (add-to-list (make-local-variable 'company-backends) 'alchemist-company)))))
    (remove-hook 'alchemist-mode-hook fn)
    (remove-hook 'alchemist-iex-mode-hook fn))

  (set! :company-backend 'elixir-mode '(alchemist-company company-yasnippet)))


(def-package! mix-format
  :commands (mix-format-before-save)
  :init
  (setq mixfmt-mix (executable-find "mix"))

  (after! elixir-mode
    (add-hook 'before-save-hook #'mix-format-before-save)))
