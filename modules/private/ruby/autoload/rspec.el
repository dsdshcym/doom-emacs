;;; private/ruby/autoload/rspec.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +rspec-verify-directory (dir)
  "Launch tests in DIR directory.
Called interactively it prompts for a directory."
  (interactive "Drspec directory: ")
  (rspec-run-single-file dir (rspec-core-options)))
