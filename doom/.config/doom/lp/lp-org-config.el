;;; lp-org-config.el -*- lexical-binding: t; -*-
;;;
;;; Personal Configuration for Org-Mode

(if (file-directory-p "~/Nextcloud/org")
  (setq org-directory "~/Nextcloud/org")
  (setq org-directory "~/Documents/org"))

(setq lp/org-capture-file (concat org-directory "/Inbox.org"))
(setq lp/org-capture-mail (concat org-directory "/Mail.org"))
(setq lp/org-capture-meeting (concat org-directory "/Meeting.org"))
(setq org-agenda-files (list org-directory))

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
  (format "#+title: %s Weekly Journal - %s, W%s\n#+created: %s\n#+keywords: journal\n#+STARTUP: show2levels\n\n"
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
           "* %? :IDEA:\n%t\n" :clock-in t :clock-resume t)
          ("n" "note" entry (file lp/org-capture-file)
           "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
          ("r" "respond" entry (file lp/org-capture-file)
           "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
          ("g" "meeting" entry (file lp/org-capture-meeting)
           "* TODO Meeting with %? :MEETING:\n%U" :clock-in t :clock-resume t :prepend t)
          ("p" "New Project" plain (file lp-org-get-project-capture)
           "" :immediate-finish nil))))


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

(add-hook 'org-load-hook #'lp-org-load-init-h 100)


(provide 'lp-org-config)
