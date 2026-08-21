;;; lp-org-config.el -*- lexical-binding: t; -*-
;;;
;;; Personal Configuration for Org-Mode

(if (file-directory-p "~/Nextcloud/org")
    (setq org-directory "~/Nextcloud/org")
  (setq org-directory "~/Documents/org"))

(setq lp/org-capture-file (concat org-directory "/Inbox.org"))
(setq lp/org-capture-mail (concat org-directory "/Mail.org"))
(setq lp/org-capture-meeting (concat org-directory "/Meeting.org"))
(setq org-agenda-files (list (expand-file-name "journal" org-directory)
                             (expand-file-name "work" org-directory)
                             (expand-file-name "projects" org-directory)
                             (expand-file-name "meetings" org-directory)))

;; Set general org-mode configurations
(setq org-log-done 'time ;; logs time of task state change
      org-M-RET-may-split-line '((default . nil)) ;; Don't split headers when M-Ret for new heading
      org-insert-heading-respect-content t ;; Add new heading below content of previous heading on M-Ret
      org-log-into-drawer t ;; Insert logging information into logbook drawer
      org-agenda-skip-scheduled-if-done 1)

(defun lp-org-get-project-capture ()
  "Create a new project org file, capturing the initial description."
  (let* ((project-name (read-string "Project name: "))
         (filename (format "projects/%s-%s.org"
                           (format-time-string "%Y%m%d")
                           (replace-regexp-in-string " " "-" project-name)))
         (filepath (expand-file-name (downcase filename) org-directory)))
    (with-temp-file filepath
      (insert (format "#+title: %s\n#+date: %s\n#+keywords:\n\n"
                      project-name
                      (format-time-string "%Y-%m-%d")))
      (insert "* Introduction\n\n"))
    (find-file filepath)
    (goto-char (point-max))))

(defun lp-org-journal-file-header (time)
  "Creates the weekly journal file header"
  (format "#+title: %s Weekly Journal - %s, W%s\n#+created: %s\n#+keywords: journal\n#+STARTUP: overview hideblocks \n\n"
          (format-time-string "%Y")
          (format-time-string "%B")
          (format-time-string "%V")
          (format-time-string "%Y-%m-%d")))

;; Set journal variables
(setq org-journal-enable-agenda-integration t
      org-journal-file-type 'weekly
      org-journal-date-format "%B %d, %Y (%A)"
      org-journal-file-header #'lp-org-journal-file-header
      org-journal-file-format "%Y-%m-%d.org")

(defun lp-org-load-init-h ()
  ;; Capture templates for: TODO tasks, Notes, meetings, etc
  (setq org-capture-templates
        `(("t" "todo" entry (file lp/org-capture-file)
           "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t :prepend t)
          ("i" "idea" entry (file lp/org-capture-file)
           "* NEXT %? :idea:\n%t\n" :clock-in t :clock-resume t)
          ("n" "note" entry (file lp/org-capture-file)
           "* NEXT %? :note:\n%U\n%a\n" :clock-in t :clock-resume t)
          ("r" "respond" entry (file lp/org-capture-file)
           "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
          ("g" "meeting" entry (file lp/org-capture-meeting)
           "* TODO Meeting with %? :MEETING:\n%U" :clock-in t :clock-resume t :prepend t)
          ("p" "New Project" plain (file lp-org-get-project-capture)
           "" :immediate-finish nil)))
  (when-let ((cell (assoc "KILL" org-todo-keyword-faces)))
    (setcdr cell 'org-done))
  (setq org-todo-keywords      ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "NEXT(n)"           ; Task to be considered next
           "WAIT(w)"           ; Something is holding up this task
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "KILL(k)" )         ; Task has been cancelled/killed
          ("INACTIVE(i)"       ; Some lost task waiting free time to be picked
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "MEETING(m)" )      ; Meeting
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)")) ; Task was completed
        org-agenda-custom-commands
        '(("d" "Daily Agenda"
           ((agenda "" ((org-agenda-span 1)
                        (org-agenda-start-day nil)
                        (org-deadline-warning-days 3)
                        (org-agenda-block-separator nil)
                        (org-scheduled-past-days 0)
                        (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                        (org-agenda-format-date "%A %-e %B %Y")
                        (org-agenda-overriding-header "\nToday's agenda\n")))
            (todo "NEXT" ((org-agenda-overriding-header "Next in queue")))
            (tags-todo "+PRIORITY=\"A\"" ((org-agenda-overriding-header "Hight Priority")))
            (todo "WAIT" ((org-agenda-overriding-header "Waiting for something")))))
          ;; Prots custom agenda
          ("A" "Daily agenda and top priority tasks"
           ((tags-todo "*"
                       ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                        (org-agenda-skip-function
                         `(org-agenda-skip-entry-if
                           'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                        (org-agenda-block-separator nil)
                        (org-agenda-overriding-header "Important tasks without a date\n")))
            (agenda "" ((org-agenda-span 1)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator nil)
                        (org-scheduled-past-days 0)
                        ;; We don't need the `org-agenda-date-today'
                        ;; highlight because that only has a practical
                        ;; utility in multi-day views.
                        (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                        (org-agenda-format-date "%A %-e %B %Y")
                        (org-agenda-overriding-header "\nToday's agenda\n")))
            (agenda "" ((org-agenda-start-on-weekday nil)
                        (org-agenda-start-day "+1d")
                        (org-agenda-span 3)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator nil)
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                        (org-agenda-overriding-header "\nNext three days\n")))
            (agenda "" ((org-agenda-time-grid nil)
                        (org-agenda-start-on-weekday nil)
                        ;; We don't want to replicate the previous section's
                        ;; three days, so we start counting from the day after.
                        (org-agenda-start-day "+4d")
                        (org-agenda-span 14)
                        (org-agenda-show-all-dates nil)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator nil)
                        (org-agenda-entry-types '(:deadline))
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                        (org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n")))))
          ("n" "Next Tasks"
           ((tags-todo "+PRIORITY=\"A\"" ((org-agenda-overriding-header "Hight Priority")))
            (todo "NEXT" ((org-agenda-overriding-header "Next in queue")))
            (todo "WAIT" ((org-agenda-overriding-header "Waiting for something")))))
          ("p" "Plan next"
           ((todo "WAIT" ((org-agenda-overriding-header "Waiting for something")))
            (todo "TODO" ((org-agenda-overriding-header "TODO tasks")))))
          ("r" "Week Review"
           ((agenda "" ((org-agenda-overriding-header "Completed Tasks")
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo 'done))
                        (org-agenda-span 'week)))
            (agenda "" ((org-agenda-overriding-header "Unfinished Scheduled Tasks")
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'nottimestamp))
                        (org-agenda-span 'week)))))
          ;; Low-effort next actions
          ("l" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
           ((org-agenda-overriding-header "Low Effort Tasks")
            ;; (org-agenda-files org-agenda-files)
            (org-agenda-max-todos 20)))))
  (add-to-list 'org-structure-template-alist '("j" . "src javascrip"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("ym" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("cl" . "src lisp"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript")))


(after! org
  (require 'org-bullets)
  (add-hook 'org-mode-hook
            (lambda()
              (org-bullets-mode 1)
              (setq org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))))
  (global-set-key (kbd "C-c a") #'org-agenda)
  (map! :leader
        :desc "Open current journal"
        "n j c" #'org-journal-open-current-journal-file
        "n j j" #'org-journal-open-current-journal-file))

;; Some visual customizations
(add-hook 'org-mode-hook
          (lambda()
            (visual-line-mode 1)
            (setq fill-column 120)
            (setq org-startup-folded 'content)
            (display-line-numbers-mode 0)))

(add-hook 'org-load-hook #'lp-org-load-init-h 100)

;; Document Centering (from Daviwil)

(defvar center-document-desired-width 0.6
  "The desired width (or percentage of the window size if less than 0) of a document centered in the window.")

(defun center-document--adjust-margins ()
  ;; Reset margins first before recalculating
  (set-window-parameter nil 'min-margins nil)
  (set-window-margins nil nil)

  ;; Adjust margins if the mode is on
  (when center-document-mode
    (let* ((total-margin-width (if (> center-document-desired-width 1)
                                   (- (window-width) center-document-desired-width)
                                 (* (window-width) (- 1 center-document-desired-width))))
           (margin-width (max 0 (truncate
                                 (/ total-margin-width 2.0)))))
      (when (> margin-width 0)
        (set-window-parameter nil 'min-margins '(0 . 0))
        (set-window-margins nil margin-width margin-width)))))

(define-minor-mode center-document-mode
  "Toggle centered text layout in the current buffer."
  :lighter " Centered"
  :group 'editing
  (if center-document-mode
      (add-hook 'window-configuration-change-hook #'center-document--adjust-margins 'append 'local)
    (remove-hook 'window-configuration-change-hook #'center-document--adjust-margins 'local))
  (center-document--adjust-margins))

;; (after! org (add-hook 'org-mode-hook #'center-document-mode))
;; (dolist (mode '(markdown-mode-hook text-mode-hook))
;;   (add-hook mode (lambda ()
;;                    (center-document-mode)
;;                    (display-line-numbers-mode 0))))

;; Event Notification
(defun lp-setup-agenda-notifier ()
  (require 'appt)
  (require 'org-agenda)
  (require 'notifications)

  ;; Setup appt scheduler
  (setq appt-message-warning-time 20)
  (setq appt-display-interval 10)
  (setq appt-display-mode-line t)
  (appt-activate 1)

  (defun lp-org-refresh-appts ()
    (setq appt-time-msg-list nil)
    (org-agenda-to-appt t))


  (add-hook 'org-agenda-finalize-hook #'lp-org-refresh-appts)
  (run-at-time "00:05" 600 #'lp-org-refresh-appts)

  (setq appt-disp-window-function
        (lambda (min-to-app _new-time msg)
          (let ((clean-msg (replace-regexp-in-string
                            ":[^ ]+:" "" msg)))
            (message clean-msg)
            (notifications-notify
             :app-name "Emacs Notifier"
             :title (format "Meeting in %s minutes" min-to-app)
             :body clean-msg
             :timeout 15000))))

  (setq appt-delete-window-function (lambda (&rest _))))

(lp-setup-agenda-notifier)

(provide 'lp-org-config)
