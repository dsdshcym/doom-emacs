;;; private/dsdshcym/bindings/elixir.el -*- lexical-binding: t; -*-

(map!
 :after alchemist
 :map alchemist-mode-map
 :localleader
 :nvmo "el" #'alchemist-eval-current-line
 :nvmo "eL" #'alchemist-eval-print-current-line
 :nvmo "er" #'alchemist-eval-region
 :nvmo "eR" #'alchemist-eval-print-region
 :nvmo "eb" #'alchemist-eval-buffer
 :nvmo "eB" #'alchemist-eval-print-buffer
 :nvmo "ej" #'alchemist-eval-quoted-current-line
 :nvmo "eJ" #'alchemist-eval-print-quoted-current-line
 :nvmo "eu" #'alchemist-eval-quoted-region
 :nvmo "eU" #'alchemist-eval-print-quoted-region
 :nvmo "ev" #'alchemist-eval-quoted-buffer
 :nvmo "eV" #'alchemist-eval-print-quoted-buffer

 :nvmo "h:" #'alchemist-help
 :nvmo "hH" #'alchemist-help-history
 :nvmo "hh" #'alchemist-help-search-at-point
 :nvmo "hr" #'alchemist-help--search-marked-region

 :nvmo "m:" #'alchemist-mix-run
 :nvmo "mc" #'alchemist-mix-compile
 :nvmo "mx" #'alchemist-mix
 :nvmo "mr" #'alchemist-mix-rerun-last-task

 :nvmo "'"  #'alchemist-iex-run
 :nvmo "sc" #'alchemist-iex-compile-this-buffer
 :nvmo "si" #'alchemist-iex-run
 :nvmo "sI" #'alchemist-iex-project-run
 :nvmo "sl" #'alchemist-iex-send-current-line
 :nvmo "sL" #'alchemist-iex-send-current-line-and-go
 :nvmo "sm" #'alchemist-iex-reload-module
 :nvmo "sr" #'alchemist-iex-send-region
 :nvmo "sR" #'alchemist-iex-send-region-and-go

 :nvmo "ta" #'alchemist-mix-test
 :nvmo "tb" #'alchemist-mix-test-this-buffer
 :nvmo "tB" #'alchemist-project-run-tests-for-current-file
 :nvmo "tt" #'alchemist-mix-test-at-point
 :nvmo "tf" #'alchemist-mix-test-file
 :nvmo "tF" #'alchemist-project-find-test
 :nvmo "tn" #'alchemist-test-mode-jump-to-next-test
 :nvmo "tp" #'alchemist-test-mode-jump-to-previous-test
 :nvmo "tr" #'alchemist-mix-rerun-last-test
 :nvmo "ts" #'alchemist-mix-test-stale
 :nvmo "tR" #'alchemist-test-toggle-test-report-display
 :nvmo "t <tab>" #'alchemist-project-toggle-file-and-tests
 :nvmo "t <S-tab>" #'alchemist-project-toggle-file-and-tests-other-window

 :nvmo "xb" #'alchemist-execute-this-buffer
 :nvmo "xf" #'alchemist-execute-file
 :nvmo "x:" #'alchemist-execute

 :nvmo "cb" #'alchemist-compile-this-buffer
 :nvmo "cf" #'alchemist-compile-file
 :nvmo "c:" #'alchemist-compile

 :nvmo "gg" #'alchemist-goto-definition-at-point
 :nvmo "." #'alchemist-goto-definition-at-point
 :nvmo "gb" #'alchemist-goto-jump-back
 :nvmo ","  #'alchemist-goto-jump-back
 :nvmo "gN" #'alchemist-goto-jump-to-previous-def-symbol
 :nvmo "gn" #'alchemist-goto-jump-to-next-def-symbol
 :nvmo "gj" #'alchemist-goto-list-symbol-definitions

 :nvmo "Xi" #'alchemist-hex-info-at-point
 :nvmo "Xr" #'alchemist-hex-releases-at-point
 :nvmo "XR" #'alchemist-hex-releases
 :nvmo "XI" #'alchemist-hex-info
 :nvmo "Xs" #'alchemist-hex-search

 :nvmo "ol" #'alchemist-macroexpand-once-current-line
 :nvmo "oL" #'alchemist-macroexpand-once-print-current-line
 :nvmo "ok" #'alchemist-macroexpand-current-line
 :nvmo "oK" #'alchemist-macroexpand-print-current-line
 :nvmo "oi" #'alchemist-macroexpand-once-region
 :nvmo "oI" #'alchemist-macroexpand-once-print-region
 :nvmo "or" #'alchemist-macroexpand-region
 :nvmo "oR" #'alchemist-macroexpand-print-region

 :nvmo "fc" #'alchemist-phoenix-find-controllers
 :nvmo "fC" #'alchemist-phoenix-find-channels
 :nvmo "fm" #'alchemist-phoenix-find-models
 :nvmo "fr" #'alchemist-phoenix-router
 :nvmo "fs" #'alchemist-phoenix-find-static
 :nvmo "ft" #'alchemist-phoenix-find-templates
 :nvmo "fv" #'alchemist-phoenix-find-views
 :nvmo "fw" #'alchemist-phoenix-find-web)
