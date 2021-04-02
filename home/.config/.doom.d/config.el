;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Luis Pereira"
    user-mail-address "luispereira.tkd@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
(setq visible-bell t)

;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq org-directory "~/Nextcloud/org/")
(after! org
  (require 'org-bullets)  ; Nicer bullets in org-mode
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1)
                             (visual-fill-column-mode 1)
                             (visual-line-mode 1)
                             ))
  (setq org-ellipsis " ▼ "))

;; babel
(after! org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t))))

(after! org
  (setq org-agenda-files (directory-files-recursively org-directory "\\.org$")
        org-log-done 'time
        org-journal-dir "~/Nextcloud/org/journal/"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"
        org-agenda-skip-scheduled-if-done 1
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
        '(("google" . "http://www.google.com/search?q=")
          ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
          ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "NEXT(n)"           ; Task to be considered next
           "WAIT(w)"           ; Something is holding up this task
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "CANCELLED(c)" )    ; Task has been cancelled
          ("INACTIVE(i)"       ; Some lost task waiting free time to be picked
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "MEETING(m)" )      ; Meeting
          )
        )
  ;; Set default column view headings: Task Total-Time Time-Stamp
  (setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")
  (setq org-startup-folded 'content)
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  )

;; Capture templates for: TODO tasks, Notes, meetings, etc
(setq org-capture-templates
      (quote (("t" "todo" entry (file concat org-directory "refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file concat org-directory "refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("i" "idea" entry (file concat org-directory "refile.org")
               "* %? :IDEA:\n%t\n" :clock-in t :clock-resume t)
              ("n" "note" entry (file concat org-directory "refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("m" "Meeting" entry (file concat org-directory "refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/git/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t))))

(setq undo-limit 80000                         ; Raise undo-limit to 80KB
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space
(setq max-list-eval-depth 400) ; trying to fix c stack overflow error. Was 800
(setq max-specpdl-size 800) ; trying to fix c stack overflow error. Was 1600

(setq evil-want-fine-undo t) ; By default while in insert all changes are one big blob. Be more granular
(global-subword-mode 1)                           ; Iterate through CamelCase words

(after! evil
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(display-time-mode 1)                             ; Enable time in the mode-line
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                       ; On laptops it's nice to know how much power you have

(after! ispell
(setenv "LANG" "en_US")
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra"))
(setq ispell-dictionary "en_US")
;; (setq ispell-dictionary "pt_PT")
;; (setq ispell-personal-dictionary (expand-file-name ".ispell_personal" doom-private-dir))
(setq ispell-local-dictionary "en_US"))
;; (setq ispell-local-dictionary "pt_PT"))
;; Spelling with hunspell
;; (after! ispell
;; (setenv "LANG" "en_US")
;; (setq ispell-program-name "hunspell")
;; (setq ispell-dictionary "pt_PT")
;; (ispell-set-spellchecker-params)
;; (ispell-hunspell-add-multi-dic "pt_PT"))

(require 'mu4e)

;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)
;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; (setq browse-url-generic-program "")
(after! mu4e
    (setq browse-url-browser-function 'browse-url-generic
            browse-url-generic-program "qutebrowser")
    (add-to-list 'mu4e-view-actions
                    '("viewInBrowser" . mu4e-action-view-in-browser) t)
)
;; the next are relative to the root maildir
;; (see `mu info`).
;; instead of strings, they can be functions too, see
;; their docstring or the chapter 'Dynamic folders'
(setq mu4e-update-interval (* 10 60))
(setq mu4e-get-mail-command "mbsync -a")
(setq mu4e-root-maildir "/mnt/coisas/.mumail")
(setq mu4e-compose-context-policy 'always-ask)

(add-to-list 'mu4e-bookmarks '("(m:/personal/Inbox or m:/professional/Inbox or m:/nibble/Inbox or m:/luispereira/Inbox) and flag:unread" "Unread inbox" ?n))
(add-to-list 'mu4e-bookmarks '("m:/personal/Inbox or m:/professional/Inbox or m:/nibble/Inbox or m:/luispereira/Inbox" "All Inboxes" ?i))


(setq mu4e-headers-time-format "%H:%M")
;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; (better only use that for the last field.
;; These are the defaults:
(setq mu4e-headers-fields
      '( (:human-date          .  15)    ;; alternatively, use :human-date
         (:flags         .   8)
         (:from          .  22)
         (:maildir       . 20)
         (:subject       .  nil))) ;; alternatively, use :thread-subject
(setq mu4e-use-fancy-chars nil)
;; smtp mail setting
(setq
 message-send-mail-function 'smtpmail-send-it
 ;; mu4e-main-buffer-hide-personal-addresses t

 ;; if you need offline mode, set these -- and create the queue dir
 ;; with 'mu mkdir', i.e.. mu mkdir /home/user/Maildir/queue
 ;; smtpmail-queue-mail  nil
 ;; smtpmail-queue-dir  "/home/user/Maildir/queue/
 )


;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)



;; for mypyls
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))
