;;; private/ruby/autoload/ruby.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +ruby-test-framework ()
  "Return current test framework. Either 'minitest or 'rspec or 'ruby-test"
  (interactive)
  (cond
   ((string-match-p "spec" (file-name-base)) 'rspec)
   ((string-match-p "test" (file-name-base)) 'minitest)
   ((projectile-file-exists-p (concat (projectile-project-root) "spec")) 'rspec)
   ((projectile-file-exists-p (concat (projectile-project-root) "test")) 'minitest)
   (t 'ruby-test)))
