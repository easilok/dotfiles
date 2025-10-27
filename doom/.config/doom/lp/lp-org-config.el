;;; lp-org-config.el -*- lexical-binding: t; -*-
;;;
;;; Personal Configuration for Org-Mode

(if (file-directory-p "~/Nextcloud/org")
  (setq org-directory "~/Nextcloud/org")
  (setq org-directory "~/Documents/org"))

(defun lp-org-get-current-journal-filepath ()
  (let ((year (format-time-string "%Y"))
        (month (format-time-string "%m"))
        (dayfile (format-time-string "%Y-%m-%d.org")))
     (file-name-concat year month dayfile)))

(setq lp/org-capture-file (concat org-directory "/Inbox.org"))
(setq lp/org-capture-mail (concat org-directory "/Mail.org"))
(setq lp/org-capture-meeting (concat org-directory "/Meeting.org"))
(setq org-agenda-files (list org-directory))

(setq org-log-done 'time ;; logs time of task state change
      org-M-RET-may-split-line '((default . nil)) ;; Don't split headers when M-Ret for new heading
      org-insert-heading-respect-content t ;; Add new heading below content of previous heading on M-Ret
      org-log-into-drawer t ;; Insert logging information into logbook drawer
      org-journal-dir (concat org-directory "/journal/")
      org-journal-date-format "%B %d, %Y (%A) "
      ;; org-journal-file-format "%Y-%m-%d.org"
      org-journal-file-format (lp-org-get-current-journal-filepath)
      org-agenda-skip-scheduled-if-done 1)

;; Capture templates for: TODO tasks, Notes, meetings, etc
(setq org-capture-templates
      `(("t" "todo" entry (file lp/org-capture-file)
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t :prepend t)
              ("i" "idea" entry (file lp/org-capture-file)
               "* %? :IDEA:\n%t\n" :clock-in t :clock-resume t)
              ("n" "note" entry (file lp/org-capture-file)
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file lp/org-capture-file)
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("g" "meeting" entry (file lp/org-capture-meeting)
               "* TODO Meeting with %? :MEETING:\n%U" :clock-in t :clock-resume t :prepend t)
              ("p" "phone call" entry (file lp/org-capture-meeting)
               "* TODO Call with %? :PHONE:\n%U" :clock-in t :clock-resume t :prepend t)))


(after! org
       (require 'org-bullets)
       (add-hook 'org-mode-hook
                 (lambda()
                   (org-bullets-mode 1)
                   (setq org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))))

;; Some visual customizations
(add-hook 'org-mode-hook
          (lambda()
            (visual-line-mode 1)
            (setq fill-column 120)
            (setq org-startup-folded 'content)))

(provide 'lp-org-config)
