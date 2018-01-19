;;; private/dsdshcym/bindings/ruby.el -*- lexical-binding: t; -*-

(map!
 (:after ruby-mode
   :map ruby-mode-map
   :localleader
   (:desc "refactor" :prefix "r"
     :nvmo "{"  #'ruby-toggle-block
     :nvmo "'"  #'ruby-toggle-string-quotes)

   (:desc "bundle" :prefix "b"
     :nvmo "c" #'bundle-check
     :nvmo "i" #'bundle-install
     :nvmo "s" #'bundle-console
     :nvmo "u" #'bundle-update
     :nvmo "x" #'bundle-exec
     :nvmo "o" #'bundle-open)

   (:desc "rake" :prefix "k"
     :nvmo "k"    'rake
     :nvmo "r"    'rake-rerun
     :nvmo "R"    'rake-regenerate-cache
     :nvmo "f"    'rake-find-task))

 (:after rspec-mode
   :map (rspec-mode-map rspec-verifiable-mode-map)
   :localleader
   :prefix "t"
   :nvmo "a"    #'rspec-verify-all
   :nvmo "b"    #'rspec-verify
   :nvmo "c"    #'rspec-verify-continue
   :nvmo "d"    #'+rspec-verify-directory
   :nvmo "e"    #'rspec-toggle-example-pendingness
   :nvmo "f"    #'rspec-verify-method
   :nvmo "l"    #'rspec-run-last-failed
   :nvmo "m"    #'rspec-verify-matching
   :nvmo "r"    #'rspec-rerun
   :nvmo "t"    #'rspec-verify-single
   :nvmo "~"    #'rspec-toggle-spec-and-target-find-example
   :nvmo "TAB"  #'rspec-toggle-spec-and-target)

 (:after minitest
   :map minitest-mode-map
   :localleader
   :prefix "t"
   :nvmo "a" 'minitest-verify-all
   :nvmo "b" 'minitest-verify
   :nvmo "r" 'minitest-rerun
   :nvmo "t" 'minitest-verify-single)

 (:after rubocop
   :map rubocop-mode-map
   :localleader
   :prefix "c"
   :nvmo "d" #'rubocop-check-directory
   :nvmo "D" #'rubocop-autocorrect-directory
   :nvmo "f" #'rubocop-check-current-file
   :nvmo "F" #'rubocop-autocorrect-current-file
   :nvmo "p" #'rubocop-check-project
   :nvmo "P" #'rubocop-autocorrect-project)

 (:after projectile-rails
   :map projectile-rails-mode-map
   :localleader
   :nvmo "fa" #'projectile-rails-find-locale
   :nvmo "fc" #'projectile-rails-find-controller
   :nvmo "fe" #'projectile-rails-find-environment
   :nvmo "fF" #'projectile-rails-find-feature
   :nvmo "fh" #'projectile-rails-find-helper
   :nvmo "fi" #'projectile-rails-find-initializer
   :nvmo "fj" #'projectile-rails-find-javascript
   :nvmo "fl" #'projectile-rails-find-lib
   :nvmo "fm" #'projectile-rails-find-model
   :nvmo "fn" #'projectile-rails-find-migration
   :nvmo "fo" #'projectile-rails-find-log
   :nvmo "fp" #'projectile-rails-find-spec
   :nvmo "fr" #'projectile-rails-find-rake-task
   :nvmo "fs" #'projectile-rails-find-spec
   :nvmo "ft" #'projectile-rails-find-test
   :nvmo "ff" #'projectile-rails-find-fixture
   :nvmo "fv" #'projectile-rails-find-view
   :nvmo "fy" #'projectile-rails-find-layout
   :nvmo "f@" #'projectile-rails-find-mailer
   ;; Goto file
   :nvmo "Fc" #'projectile-rails-find-current-controller
   :nvmo "Fd" #'projectile-rails-goto-schema
   :nvmo "Fe" #'projectile-rails-goto-seeds
   :nvmo "Fh" #'projectile-rails-find-current-helper
   :nvmo "Fj" #'projectile-rails-find-current-javascript
   :nvmo "Fg" #'projectile-rails-goto-gemfile
   :nvmo "Fm" #'projectile-rails-find-current-model
   :nvmo "Fn" #'projectile-rails-find-current-migration
   :nvmo "Fp" #'projectile-rails-find-current-spec
   :nvmo "Fr" #'projectile-rails-goto-routes
   :nvmo "Fs" #'projectile-rails-find-current-spec
   :nvmo "Ft" #'projectile-rails-find-current-test
   :nvmo "Ff" #'projectile-rails-find-current-fixture
   :nvmo "Fv" #'projectile-rails-find-current-view
   :nvmo "Fz" #'projectile-rails-goto-spec-helper
   :nvmo "F." #'projectile-rails-goto-file-at-point
   ;; Rails external commands
   :nvmo "pk" #'projectile-rails-rake
   :nvmo "pg" #'projectile-rails-generate
   :nvmo "pi" #'projectile-rails-console
   :nvmo "ps" #'projectile-rails-server
   ;; Refactoring 'projectile-rails-mode
   :nvmo "rx" #'projectile-rails-extract-region))
