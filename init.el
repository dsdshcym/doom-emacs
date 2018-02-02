;;; init.el -*- lexical-binding: t; -*-
;;
;; Author:  Henrik Lissner <henrik@lissner.net>
;; URL:     https://github.com/hlissner/.emacs.d
;;
;;   =================     ===============     ===============   ========  ========
;;   \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
;;   ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
;;   || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
;;   ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
;;   || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
;;   ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
;;   || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
;;   ||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
;;   ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
;;   ||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
;;   ||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
;;   ||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
;;   ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
;;   ||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
;;   ||.=='    _-'                                                     `' |  /==.||
;;   =='    _-'                                                            \/   `==
;;   \   _-'                                                                `-_   /
;;    `''                                                                      ``'
;;
;; These demons are not part of GNU Emacs.
;;
;;; License: MIT

(require 'core (concat user-emacs-directory "core/core"))

(doom! :feature
       (popup
        +all
        +defaults)
      ;debugger          ; FIXME stepping through code, to help you add bugs
       eval              ; run code, run (also, repls)
       evil              ; come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       (lookup           ; helps you navigate your code and documentation
        +docsets)        ; ...or in Dash docsets locally
       snippets          ; my elves. They type so I don't have to
       spellcheck        ; tasing you for misspelling mispelling
       syntax-checker    ; tasing you for every semicolon you forget
       version-control   ; remember, remember that commit in November

       :completion
       company           ; the ultimate code completion backend
       ivy               ; a search engine for love and life

       :ui
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-modeline     ; a snazzy Atom-inspired mode-line
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE tags
       (window-select +ace-window)  ; visually switch windows

       :tools
       electric-indent   ; smarter, keyword-based electric-indent
       dired
       eshell            ; a consistent, cross-platform shell (WIP)
       gist              ; interacting with github gists
       imenu             ; an imenu sidebar and searchable code index
       impatient-mode    ; show off code over HTTP
       macos             ; MacOS-specific commands
       make              ; run make tasks from Emacs
       rotate-text       ; cycle region at point between text candidates
       term              ; terminals in Emacs

       :lang
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       ledger            ; an accounting system in Emacs
       lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       plantuml          ; diagrams for confusing people more
       sh                ; she sells (ba|z)sh shells on the C xor
       web               ; the tubes
       elixir

       :private
       ui
       ruby
       dsdshcym
       org
       org-page
       chinese
       mu4e
       elfeed
       chrome
       )
