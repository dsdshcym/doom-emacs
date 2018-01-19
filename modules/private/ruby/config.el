;;; private/ruby/config.el -*- lexical-binding: t; -*-

(def-package! ruby-mode
  :mode "\\.rb$"
  :mode "\\.rake$"
  :mode "\\.gemspec$"
  :mode "\\.\\(pry\\|irb\\)rc$"
  :mode "/\\(Gem\\|Cap\\|Vagrant\\|Rake\\|Pod\\|Puppet\\|Berks\\)file$"
  :interpreter "ruby"
  :config
  (set! :electric 'ruby-mode :words '("else" "end" "elseif"))

  ;; Don't interfere with my custom RET behavior
  (define-key ruby-mode-map [?\n] nil)

  (add-hook 'ruby-mode-hook #'flycheck-mode))

(def-package! inf-ruby
  :commands (inf-ruby inf-ruby-console-auto)
  :init
  (set! :popup "\\*ruby\\*" '((size . 20)) '((quit)))
  (set! :repl 'ruby-mode 'inf-ruby))

(def-package! company-inf-ruby
  :when (featurep! :completion company)
  :after inf-ruby
  (set! :company-backend 'inf-ruby-mode '(company-inf-ruby)))

(def-package! robe
  :after ruby-mode
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  (set! :lookup 'ruby-mode
    :definition #'robe-jump
    :documentation #'robe-doc)
  (set! :company-backend 'ruby-mode '(company-robe)))

(def-package! rbenv
  :after ruby-mode
  :config
  (global-rbenv-mode)
  (add-hook 'ruby-mode-hook 'rbenv-use-corresponding))

(def-package! bundler
  :commands (bundle-check
             bundle-install
             bundle-console
             bundle-update
             bundle-exec
             bundle-open))

(def-package! rspec-mode
  :init
  (associate! rspec-mode :match "_spec\\.rb$")
  (associate! rspec-verifiable-mode :modes (ruby-mode) :files "spec/")
  :config
  (remove-hook 'ruby-mode-hook #'rspec-enable-appropriate-mode)
  (set! :popup "^\\*rspec"
     '((size . 0.35)) '((transient . 0) (select . ignore))))

(def-package! minitest
  :init
  (associate! minitest-mode :match "_test\\.rb$")
  (associate! minitest-mode :modes (ruby-mode) :files "test/")
  :config
  (remove-hook 'ruby-mode-hook 'minitest-enable-appropriate-mode)
  (set! :popup "^\\*Minitest"
     '((size . 0.35)) '((transient . 0) (select . ignore))))

(def-package! rubocop
  :commands (rubocop-mode)
  :init
  (add-hook 'ruby-mode-hook 'rubocop-mode))

(def-package! rake
  :commands (rake rake-find-task)
  :init
  (setq rake-cache-file (concat doom-cache-dir "rake.cache"))
  (setq rake-completion-system 'default))

(load! +rails)
