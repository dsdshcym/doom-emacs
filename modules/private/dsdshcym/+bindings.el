;;; private/default/+bindings.el -*- lexical-binding: t; -*-

;; This files defines a Spacemacs-esque keybinding scheme

(load! bindings/leader)
(load! bindings/elixir)
(load! bindings/ruby)

(map! (:map compilation-mode-map
        doom-leader-key nil
        doom-localleader-key nil)

      ;; --- Global keybindings ---------------------------
      ;; Make M-x available everywhere
      :gnvime "M-x" #'execute-extended-command
      :gnvime "A-x" #'execute-extended-command

      ;; --- Personal vim-esque bindings ------------------
      :n  "zx" #'doom/kill-this-buffer
      :n  "ZX" #'bury-buffer
      :m  "gt" #'+workspace/switch-right
      :m  "gT" #'+workspace/switch-left
      :m  "gd" #'+lookup/definition
      :m  "gD" #'+lookup/references
      :m  "gh" #'+lookup/documentation
      :n  "gp" #'+evil/reselect-paste
      :n  "gr" #'+eval:region
      :n  "gR" #'+eval/buffer
      :v  "gR" #'+eval:replace-region
      :v  "@"  #'+evil:macro-on-all-lines
      :n  "g@" #'+evil:macro-on-all-lines
      ;; paste from recent yank register (which isn't overwritten)
      :v  "C-p" "\"0p"

      :nv "C-a" #'evil-numbers/inc-at-pt
      :nv "C-x" #'evil-numbers/dec-at-pt

      ;; --- Plugin bindings ------------------------------
      ;; auto-yasnippet
      :i  [C-tab] #'aya-expand
      :nv [C-tab] #'aya-create

      ;; company-mode (vim-like omnicompletion)
      (:prefix "C-x"
        :i "C-l"   #'+company/whole-lines
        :i "C-k"   #'+company/dict-or-keywords
        :i "C-f"   #'company-files
        :i "C-]"   #'company-etags
        :i "s"     #'company-ispell
        :i "C-s"   #'company-yasnippet
        :i "C-o"   #'company-capf
        :i "C-n"   #'company-dabbrev-code
        :i "C-p"   #'+company/dabbrev-code-previous)
      (:after company
        (:map company-active-map
          ;; Don't interfere with `evil-delete-backward-word' in insert mode
          "C-w"        nil
          "C-o"        #'company-search-kill-others
          "C-n"        #'company-select-next
          "C-p"        #'company-select-previous
          "C-h"        #'company-quickhelp-manual-begin
          "C-S-h"      #'company-show-doc-buffer
          "C-S-s"      #'company-search-candidates
          "C-s"        #'company-filter-candidates
          "C-SPC"      #'company-complete-common
          "C-h"        #'company-quickhelp-manual-begin
          [tab]        #'company-complete-common-or-cycle
          [backtab]    #'company-select-previous
          [escape]     (λ! (company-abort) (evil-normal-state 1)))
        ;; Automatically applies to `company-filter-map'
        (:map company-search-map
          "C-n"        #'company-search-repeat-forward
          "C-p"        #'company-search-repeat-backward
          "C-s"        (λ! (company-search-abort) (company-filter-candidates))
          [escape]     #'company-search-abort))

      ;; counsel
      (:after counsel
        (:map counsel-ag-map
          [backtab]  #'+ivy/wgrep-occur      ; search/replace on results
          "C-SPC"    #'ivy-call-and-recenter ; preview
          "M-RET"    (+ivy-do-action! #'+ivy-git-grep-other-window-action)))

      ;; evil-commentary
      :n  "gc"  #'evil-commentary

      ;; evil-exchange
      :n  "gx"  #'evil-exchange

      ;; evil-matchit
      :nv [tab] #'+evil/matchit-or-toggle-fold

      ;; evil-magit
      (:after evil-magit
        :map (magit-status-mode-map magit-revision-mode-map)
        :n "C-j" nil
        :n "C-k" nil)

      ;; evil-mc
      (:prefix "gz"
        :nv "m" #'evil-mc-make-all-cursors
        :nv "u" #'evil-mc-undo-all-cursors
        :nv "z" #'+evil/mc-make-cursor-here
        :nv "t" #'+evil/mc-toggle-cursors
        :nv "n" #'evil-mc-make-and-goto-next-cursor
        :nv "p" #'evil-mc-make-and-goto-prev-cursor
        :nv "N" #'evil-mc-make-and-goto-last-cursor
        :nv "P" #'evil-mc-make-and-goto-first-cursor
        :nv "d" #'evil-mc-make-and-goto-next-match
        :nv "D" #'evil-mc-make-and-goto-prev-match)
      (:after evil-mc
        :map evil-mc-key-map
        :nv "C-n" #'evil-mc-make-and-goto-next-cursor
        :nv "C-N" #'evil-mc-make-and-goto-last-cursor
        :nv "C-p" #'evil-mc-make-and-goto-prev-cursor
        :nv "C-P" #'evil-mc-make-and-goto-first-cursor)

      ;; evil-multiedit
      :v  "R"     #'evil-multiedit-match-all
      :n  "M-d"   #'evil-multiedit-match-symbol-and-next
      :n  "M-D"   #'evil-multiedit-match-symbol-and-prev
      :v  "M-d"   #'evil-multiedit-match-and-next
      :v  "M-D"   #'evil-multiedit-match-and-prev
      :nv "C-M-d" #'evil-multiedit-restore
      (:after evil-multiedit
        (:map evil-multiedit-state-map
          "M-d" #'evil-multiedit-match-and-next
          "M-D" #'evil-multiedit-match-and-prev
          "RET" #'evil-multiedit-toggle-or-restrict-region)
        (:map (evil-multiedit-state-map evil-multiedit-insert-state-map)
          "C-n" #'evil-multiedit-next
          "C-p" #'evil-multiedit-prev))

      ;; evil-surround
      :v  "s"  #'evil-surround-region
      :o  "s"  #'evil-surround-edit
      :o  "S"  #'evil-Surround-edit

      ;; expand-region
      (:leader
        :v  "v"  #'er/expand-region
        :v  "V"  #'er/contract-region)

      ;; flycheck
      :m  "]e" #'next-error
      :m  "[e" #'previous-error
      (:after flycheck
        :map flycheck-error-list-mode-map
        :n "C-n" #'flycheck-error-list-next-error
        :n "C-p" #'flycheck-error-list-previous-error
        :n "j"   #'flycheck-error-list-next-error
        :n "k"   #'flycheck-error-list-previous-error
        :n "RET" #'flycheck-error-list-goto-error)

      ;; flyspell
      :m  "]S" #'flyspell-correct-word-generic
      :m  "[S" #'flyspell-correct-previous-word-generic

      ;; git-gutter
      :m  "]d" #'git-gutter:next-hunk
      :m  "[d" #'git-gutter:previous-hunk

      ;; git-timemachine
      (:after git-timemachine
        (:map git-timemachine-mode-map
          :n "C-p" #'git-timemachine-show-previous-revision
          :n "C-n" #'git-timemachine-show-next-revision
          :n "[["  #'git-timemachine-show-previous-revision
          :n "]]"  #'git-timemachine-show-next-revision
          :n "q"   #'git-timemachine-quit
          :n "gb"  #'git-timemachine-blame))

      ;; gist
      (:after gist
        :map gist-list-menu-mode-map
        :n "RET" #'+gist/open-current
        :n "b"   #'gist-browse-current-url
        :n "c"   #'gist-add-buffer
        :n "d"   #'gist-kill-current
        :n "f"   #'gist-fork
        :n "q"   #'quit-window
        :n "r"   #'gist-list-reload
        :n "s"   #'gist-star
        :n "S"   #'gist-unstar
        :n "y"   #'gist-print-current-url)


      ;; hl-todo
      :m  "]t" #'hl-todo-next
      :m  "[t" #'hl-todo-previous

      ;; ivy
      (:after ivy
        :map ivy-minibuffer-map
        [escape] #'keyboard-escape-quit
        "C-r" #'evil-paste-from-register
        "C-l" #'ivy-alt-done
        "C-w" #'ivy-backward-kill-word
        "C-u" #'ivy-kill-line)

      ;; realgud
      (:after realgud
        :map realgud:shortkey-mode-map
        :n "j" #'evil-next-line
        :n "k" #'evil-previous-line
        :n "h" #'evil-backward-char
        :n "l" #'evil-forward-char
        :m "n" #'realgud:cmd-next
        :m "b" #'realgud:cmd-break
        :m "B" #'realgud:cmd-clear
        :n "c" #'realgud:cmd-continue)

      ;; rotate-text
      :n  "!"  #'rotate-text

      ;; smart-forward
      :m  "g]" #'smart-forward
      :m  "g[" #'smart-backward

      ;; undo-tree -- undo/redo for visual regions
      :v "C-u" #'undo-tree-undo
      :v "C-r" #'undo-tree-redo

      ;; yasnippet
      (:after yasnippet
        (:map yas-keymap
          "C-e"           #'+snippets/goto-end-of-field
          "C-a"           #'+snippets/goto-start-of-field
          "<M-right>"     #'+snippets/goto-end-of-field
          "<M-left>"      #'+snippets/goto-start-of-field
          "<M-backspace>" #'+snippets/delete-to-start-of-field
          [escape]        #'evil-normal-state
          [backspace]     #'+snippets/delete-backward-char
          [delete]        #'+snippets/delete-forward-char-or-field)
        (:map yas-minor-mode-map
          :i "<tab>" yas-maybe-expand
          :v "<tab>" #'+snippets/expand-on-region))

      ;; --- Major mode bindings --------------------------
      (:after markdown-mode
        (:map markdown-mode-map
          ;; fix conflicts with private bindings
          "<backspace>" nil
          "<M-left>"    nil
          "<M-right>"   nil))


      ;; --- Custom evil text-objects ---------------------
      :textobj "a" #'evil-inner-arg                    #'evil-outer-arg
      :textobj "B" #'evil-textobj-anyblock-inner-block #'evil-textobj-anyblock-a-block
      :textobj "i" #'evil-indent-plus-i-indent         #'evil-indent-plus-a-indent
      :textobj "I" #'evil-indent-plus-i-indent-up      #'evil-indent-plus-a-indent-up
      :textobj "J" #'evil-indent-plus-i-indent-up-down #'evil-indent-plus-a-indent-up-down


      ;; --- Built-in plugins -----------------------------
      (:after comint
        ;; TAB auto-completion in term buffers
        :map comint-mode-map [tab] #'company-complete)

      (:after debug
        ;; For elisp debugging
        :map debugger-mode-map
        :n "RET" #'debug-help-follow
        :n "e"   #'debugger-eval-expression
        :n "n"   #'debugger-step-through
        :n "c"   #'debugger-continue)

      (:map help-mode-map
        :n "[["  #'help-go-back
        :n "]]"  #'help-go-forward
        :n "o"   #'ace-link-help
        :n "q"   #'quit-window
        :n "Q"   #'+ivy-quit-and-resume)

      (:after vc-annotate
        :map vc-annotate-mode-map
        :n "q"   #'kill-this-buffer
        :n "d"   #'vc-annotate-show-diff-revision-at-line
        :n "D"   #'vc-annotate-show-changeset-diff-revision-at-line
        :n "SPC" #'vc-annotate-show-log-revision-at-line
        :n "]]"  #'vc-annotate-next-revision
        :n "[["  #'vc-annotate-prev-revision
        :n "TAB" #'vc-annotate-toggle-annotation-visibility
        :n "RET" #'vc-annotate-find-revision-at-line))


;;
;; Keybinding fixes
;;

;; This section is dedicated to "fixing" certain keys so that they behave
;; properly, more like vim, or how I like it.

(map! (:map input-decode-map
        [S-iso-lefttab] [backtab]
        "C-h" [backspace]
        (:unless window-system "TAB" [tab])) ; Fix TAB in terminal

      ;; I want C-a and C-e to be a little smarter. C-a will jump to
      ;; indentation. Pressing it again will send you to the true bol. Same goes
      ;; for C-e, except it will ignore comments and trailing whitespace before
      ;; jumping to eol.
      :i "C-a" #'doom/backward-to-bol-or-indent
      :i "C-e" #'doom/forward-to-last-non-comment-or-eol
      :i "C-u" #'doom/backward-kill-to-bol-and-indent

      ;; Highjacks space/backspace to:
      ;;   a) balance spaces inside brackets/parentheses ( | ) -> (|)
      ;;   b) delete space-indented blocks intelligently
      ;;   c) do none of this when inside a string
      :i "SPC"                          #'doom/inflate-space-maybe
      :i [remap delete-backward-char]   #'doom/deflate-space-maybe
      :i [remap newline]                #'doom/newline-and-indent

      ;; Restore common editing keys (and ESC) in minibuffer
      (:map (minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map
             minibuffer-local-isearch-map
             evil-ex-completion-map
             evil-ex-search-keymap
             read-expression-map)
        [escape] #'abort-recursive-edit
        "C-r" #'evil-paste-from-register
        "C-a" #'move-beginning-of-line
        "C-w" #'doom/minibuffer-kill-word
        "C-u" #'doom/minibuffer-kill-line)

      (:map messages-buffer-mode-map
        "M-;" #'eval-expression
        "A-;" #'eval-expression)

      (:map tabulated-list-mode-map
        [remap evil-record-macro] #'doom/popup-close-maybe)

      (:after view
        (:map view-mode-map "<escape>" #'View-quit-all)))

(after! wdired
  (map! :map dired-mode-map
        :localleader
        :n "w" 'wdired-change-to-wdired-mode))

(after! compile
  (map! :map compilation-mode-map
        :prefix "g"
        :nvm "g" #'evil-goto-first-line
        :nvm "r" #'recompile))

(map!
 (:after osx-dictionary
   :map osx-dictionary-mode-map
   :n "q" #'osx-dictionary-quit
   :n "r" #'osx-dictionary-read-word
   :n "s" #'osx-dictionary-search-input
   :n "o" #'osx-dictionary-open-dictionary.app))
