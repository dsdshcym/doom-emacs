
(map!
 :nmvo doom-leader-key nil
 :nmvo doom-localleader-key nil

 (:leader
   ;; Most commonly used
   :desc "M-x"                         :nmvo "SPC"                  #'execute-extended-command
   :desc "alternative buffer"          :nmvo "TAB"   (lambda () (interactive) (switch-to-buffer nil))

   :desc "Universal argument"          :nmvo "u"  #'universal-argument
   :desc "Projectile search"           :nmvo "/" #'counsel-projectile-rg

   (:desc "previous..." :prefix "["
     :desc "Text size"                 :nmvo "[" #'smart-backward
     :desc "Buffer"                    :nmvo "b" #'doom/previous-buffer
     :desc "Diff Hunk"                 :nmvo "d" #'git-gutter:previous-hunk
     :desc "Todo"                      :nmvo "t" #'hl-todo-previous
     :desc "Error"                     :nmvo "e" #'previous-error
     :desc "Workspace"                 :nmvo "w" #'+workspace/switch-left
     :desc "Spelling error"            :nmvo "s" #'evil-prev-flyspell-error
     :desc "Spelling correction"       :nmvo  "S" #'flyspell-correct-previous-word-generic)

   (:desc "next..." :prefix "]"
     :desc "Text size"                 :nmvo "]" #'smart-forward
     :desc "Buffer"                    :nmvo "b" #'doom/next-buffer
     :desc "Diff Hunk"                 :nmvo "d" #'git-gutter:next-hunk
     :desc "Todo"                      :nmvo "t" #'hl-todo-next
     :desc "Error"                     :nmvo "e" #'next-error
     :desc "Workspace"                 :nmvo "w" #'+workspace/switch-right
     :desc "Spelling error"            :nmvo "s" #'evil-next-flyspell-error
     :desc "Spelling correction"       :nmvo  "S" #'flyspell-correct-word-generic)

   (:desc "apps" :prefix "a"
     :nmvo "a" #'org-agenda-list
     :nmvo "m" #'mu4e
     :nmvo "u" #'undo-tree-visualize
     :nmvo "f" #'elfeed)

   (:desc "search" :prefix "s"
     :desc "Swiper"                    :nmvo "s" #'swiper
     :desc "Imenu"                     :nmvo "i" #'imenu
     :desc "Imenu across buffers"      :nmvo "I" #'imenu-anywhere
     :desc "Online providers"          :nmvo "o" #'+lookup/online-select)

   (:desc "definition" :prefix "d"
     :desc "Dash"                       :nmvo "d" #'dash-at-point
     :desc "Dash (ask for Docset)"      :nmvo "D" #'dash-at-point-with-docset
     :desc "dictionary"                 :nmvo "w" #'osx-dictionary-search-pointer
     :desc "dictionary (ask for input)" :nmvo "W" #'osx-dictionary-search-input)

   :desc "window"                      :nmvo "w"  evil-window-map
   (:desc "window management" :prefix "w"
     :desc "New frame"                 :nmvo "f" #'make-frame
     :desc "Toggle Popup"              :nmvo "p" #'+popup/toggle
     :desc "Delete window"             :nmvo "d" #'evil-window-delete
     :desc "Maximize window"           :nmvo "m" #'delete-other-windows
     :desc "Winner Undo"               :nmvo "u" #'winner-undo
     :desc "Winner Redo"               :nmvo "r" #'winner-redo)

   (:desc "workspace" :prefix "W"
     :desc "Display tab bar"           :nmvo "TAB" #'+workspace/display
     :desc "New workspace"             :nmvo "n"   #'+workspace/new
     :desc "Load workspace from file"  :nmvo "l"   #'+workspace/load
     :desc "Load last session"         :nmvo "L"   (λ! (+workspace/load-session))
     :desc "Save workspace to file"    :nmvo "s"   #'+workspace/save
     :desc "Autosave current session"  :nmvo "S"   #'+workspace/save-session
     :desc "Switch workspace"          :nmvo "."   #'+workspace/switch-to
     :desc "Kill all buffers"          :nmvo "x"   #'doom/kill-all-buffers
     :desc "Delete session"            :nmvo "X"   #'+workspace/kill-session
     :desc "Delete this workspace"     :nmvo "d"   #'+workspace/delete
     :desc "Load session"              :nmvo "L"   #'+workspace/load-session
     :desc "Next workspace"            :nmvo "]"   #'+workspace/switch-right
     :desc "Previous workspace"        :nmvo "["   #'+workspace/switch-left
     :desc "Switch to 1st workspace"   :nmvo "1"   (λ! (+workspace/switch-to 0))
     :desc "Switch to 2nd workspace"   :nmvo "2"   (λ! (+workspace/switch-to 1))
     :desc "Switch to 3rd workspace"   :nmvo "3"   (λ! (+workspace/switch-to 2))
     :desc "Switch to 4th workspace"   :nmvo "4"   (λ! (+workspace/switch-to 3))
     :desc "Switch to 5th workspace"   :nmvo "5"   (λ! (+workspace/switch-to 4))
     :desc "Switch to 6th workspace"   :nmvo "6"   (λ! (+workspace/switch-to 5))
     :desc "Switch to 7th workspace"   :nmvo "7"   (λ! (+workspace/switch-to 6))
     :desc "Switch to 8th workspace"   :nmvo "8"   (λ! (+workspace/switch-to 7))
     :desc "Switch to 9th workspace"   :nmvo "9"   (λ! (+workspace/switch-to 8))
     :desc "Switch to last workspace"  :nmvo "0"   #'+workspace/switch-to-last)

   (:desc "buffer" :prefix "b"
     :desc "Scratch"                   :nmvo "s" #'doom/open-scratch-buffer
     :desc "New empty buffer"          :nmvo "n" #'evil-buffer-new
     :desc "Switch buffer"             :nmvo "b" #'switch-to-buffer
     :desc "Kill buffer"               :nmvo "d" #'kill-this-buffer
     :desc "Kill other buffers"        :nmvo "D" #'doom/kill-other-buffers
     :desc "Bury buffer"               :nmvo "z" #'bury-buffer
     :desc "Next buffer"               :nmvo "]" #'doom/next-buffer
     :desc "Previous buffer"           :nmvo "[" #'doom/previous-buffer
     :desc "Sudo edit this file"       :nmvo "S" #'doom/sudo-this-file
     :desc "Messages"                  :nmvo "m" (λ! (switch-to-buffer "*Messages*")))

   (:desc "code" :prefix "c"
     :desc "List errors"               :nmvo  "x" #'flycheck-list-errors
     :desc "Evaluate buffer/region"    :nmvo  "e" #'+eval/buffer
     :v  "e" #'+eval/region
     :desc "Evaluate & replace region" :nmvo "E" #'+eval:replace-region
     :desc "Build tasks"               :nmvo "b" #'+eval/build
     :desc "Jump to definition"        :nmvo  "d" #'+lookup/definition
     :desc "Jump to references"        :nmvo  "D" #'+lookup/references
     :desc "Open REPL"                 :nmvo  "r" #'+eval/open-repl
     :v  "r" #'+eval:repl)

   (:desc "file" :prefix "f"
     :desc "Find file"                  :nmvo "f" #'find-file
     :desc "Sudo find file"             :nmvo "F" #'doom/sudo-find-file
     :desc "Save file"                  :nmvo "s" #'evil-write
     :desc "Find file in emacs.d"       :nmvo "e" #'+default/find-in-emacsd
     :desc "Recent files"               :nmvo "r" #'recentf-open-files
     :desc "Yank filename"              :nmvo "y" #'+default/yank-buffer-filename
     :desc "Open Dired"                 :nmvo "d" #'dired-jump
     :desc "Open Dired in other window" :nmvo "D" #'dired-jump-other-window)

   (:desc "git" :prefix "g"
     :desc "Git status"                :nmvo  "s" #'magit-status
     :desc "Git blame"                 :nmvo  "b" #'magit-blame
     :desc "Git time machine"          :nmvo  "t" #'git-timemachine-toggle
     :desc "List gists"                :nmvo  "i" #'+gist:list
     :desc "Next hunk"                 :nmvo "]" #'git-gutter:next-hunk
     :desc "Previous hunk"             :nmvo "[" #'git-gutter:previous-hunk

     (:desc "git-link" :prefix "l"
       :desc "Git Link"                :nmvo "l" #'git-link
       :desc "Git Link Commit"         :nmvo "c" #'git-link-commit
       :desc "Git Link Homepage"       :nmvo "h" #'git-link-homepage))

   (:desc "help" :prefix "h"
     :nmvo "h" help-map
     :desc "Apropos"                   :nmvo  "a" #'apropos
     :desc "Reload theme"              :nmvo  "R" #'doom//reload-theme
     :desc "Find library"              :nmvo  "l" #'find-library
     :desc "Toggle Emacs log"          :nmvo  "m" #'doom/popup-toggle-messages
     :desc "Command log"               :nmvo  "L" #'global-command-log-mode
     :desc "Describe function"         :nmvo  "f" #'describe-function
     :desc "Describe key"              :nmvo  "k" #'describe-key
     :desc "Describe char"             :nmvo  "c" #'describe-char
     :desc "Describe mode"             :nmvo  "M" #'describe-mode
     :desc "Describe variable"         :nmvo  "v" #'describe-variable
     :desc "Describe face"             :nmvo  "F" #'describe-face
     :desc "Describe DOOM setting"     :nmvo  "s" #'doom/describe-setting
     :desc "Describe DOOM module"      :nmvo  "d" #'doom/describe-module
     :desc "Find definition"           :nmvo  "." #'+lookup/definition
     :desc "Find references"           :nmvo  "/" #'+lookup/references
     :desc "Find documentation"        :nmvo  "h" #'+lookup/documentation
     :desc "What face"                 :nmvo  "'" #'doom/what-face
     :desc "What minor modes"          :nmvo  ";" #'doom/what-minor-mode
     :desc "Info"                      :nmvo  "i" #'info
     :desc "Toggle profiler"           :nmvo  "p" #'doom/toggle-profiler)

   (:desc "insert" :prefix "i"
     :desc "From kill-ring"            :nmvo "y" #'counsel-yank-pop
     :desc "From snippet"              :nmvo "s" #'yas-insert-snippet)

   (:desc "org" :prefix "o"
     :nmvo "p" #'org-pomodoro
     :nmvo "a" #'org-agenda
     :nmvo "l" #'org-store-link
     :nmvo "L" #'org-insert-link-global
     :nmvo "b" #'org-iswitchb
     :nmvo "s" #'org-save-all-org-buffers
     :nmvo "g" #'org-clock-goto
     :nmvo "o" #'org-clock-out
     :nmvo "c" #'org-capture
     :nmvo "C" #'org-capture-goto-last-stored
     :nmvo "j" (lambda () (interactive) (org-refile '(4)))
     :nmvo "J" #'org-refile-goto-last-stored)

   (:desc "project" :prefix "p"
     :desc "Find file in project"      :nmvo  "f" #'projectile-find-file
     :desc "Run cmd in project root"   :nmvo  "!" #'projectile-run-shell-command-in-root
     :desc "Switch project"            :nmvo  "p" #'projectile-switch-project
     :desc "Recent project files"      :nmvo  "r" #'projectile-recentf
     :desc "List project tasks"        :nmvo  "t" #'+ivy/tasks
     :desc "Invalidate cache"          :nmvo  "x" #'projectile-invalidate-cache
     :desc "Kill all project buffers"  :nmvo  "k" #'projectile-kill-buffers
     )

   (:desc "quit" :prefix "q"
     :desc "Quit"                      :nmvo "q" #'evil-save-and-quit
     :desc "Quit (forget session)"     :nmvo "Q" #'+workspace/kill-session-and-quit)

   (:desc "snippets" :prefix "S"
     :desc "New snippet"               :nmvo  "n" #'yas-new-snippet
     :desc "Insert snippet"            :nmvo "i" #'yas-insert-snippet
     :desc "Find snippet for mode"     :nmvo  "s" #'yas-visit-snippet-file
     :desc "Find snippet"              :nmvo  "S" #'+default/find-in-snippets)

   (:desc "toggle" :prefix "t"
     :desc "Flyspell"                  :nmvo "s" #'flyspell-mode
     :desc "Flycheck"                  :nmvo "f" #'flycheck-mode
     :desc "Line numbers"              :nmvo "l" #'doom/toggle-line-numbers
     :desc "Fullscreen"                :nmvo "f" #'doom/toggle-fullscreen
     :desc "Indent guides"             :nmvo "i" #'highlight-indentation-mode
     :desc "Indent guides (column)"    :nmvo "I" #'highlight-indentation-current-column-mode
     :desc "Impatient mode"            :nmvo "h" #'+impatient-mode/toggle
     :desc "Big mode"                  :nmvo "b" #'doom-big-font-mode
     :desc "Evil goggles"              :nmvo "g" #'+evil-goggles/toggle)

   (:desc "jump" :prefix "j"
     :m "b" 'avy-pop-mark
     :m "j" 'avy-goto-char-2
     :m "l" 'avy-goto-line)))
