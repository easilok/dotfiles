(defun lp/org-font-setup ()
  (with-eval-after-load 'org
    ;; Increase the size of various headings
    (set-face-attribute 'org-document-title nil :font "Iosevka Aile" :weight 'bold :height 1.3)
    ;; Set faces for heading levels
    (dolist (face '((org-level-1 . 1.2)
                    (org-level-2 . 1.1)
                    (org-level-3 . 1.05)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
      (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'regular :height (cdr face)))
    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    ;; (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
    (custom-set-faces '(org-checkbox ((t (:foreground nil :inherit org-todo)))))
    (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
    (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
    (setq org-fontify-done-headline t)
    (setq org-fontify-quote-and-verse-blocks t)
    (setq org-fontify-whole-heading-line t)
    (setq org-src-fontify-natively t)
    (setq org-imenu-depth 8)
    ;; Sub-lists should have different bullets
    (setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a.")))
    ))

(with-eval-after-load 'org-faces
  (lp/org-font-setup))

(font-lock-add-keywords
 'org-mode
 `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)" 1 'org-headline-done prepend))
 'append)

(use-package org-appear
  :straight t
  :hook (org-mode . org-appear-mode)
  :custom
  (org-hide-emphasis-markers t))

(defun lp/org-mode-setup ()
  (org-indent-mode)
  ;; (variable-pitch-mode)
  ;; (auto-fill-mode 0)
  (visual-line-mode 1)
  ;; (setq evil-auto-indent nil)
  )

(defun lp/capture-mail-follow-up (msg)
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "mf"))

(defun lp/capture-mail-read-later (msg)
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "mr"))

;; add :immediate-finish t at the end of each entry to void confirmation
(defun lp/mu4e-org-setup()
  (with-eval-after-load 'mu4e
    (require 'mu4e-org)
    (setq org-capture-templates
          (append org-capture-templates
                  `(("m" "Email Workflow")
                    ("mf" "Follow Up" entry (file+olp lp/org-capture-mail "Follow Up")
                     "* TODO Follow up with %:fromname on %a\n%i")
                    ("mr" "Read Later" entry (file+olp lp/org-capture-mail "Read Later")
                     "* TODO Read %:subject\n\n%a\n\n%i" ))))
    ;; Add custom actions for our capture templates
    (add-to-list 'mu4e-headers-actions
                 '("follow up" . lp/capture-mail-follow-up) t)
    (add-to-list 'mu4e-view-actions
                 '("follow up" . lp/capture-mail-follow-up) t)
    (add-to-list 'mu4e-headers-actions
                 '("read later" . lp/capture-mail-read-later) t)
    (add-to-list 'mu4e-view-actions
                 '("read later" . lp/capture-mail-read-later) t)
    ))

(use-package org
  :straight t
  ;; :pin org
  :hook (org-mode . lp/org-mode-setup)
  :config
  (setq-default org-adapt-indentation t)
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-startup-folded 'content
        org-cycle-separator-lines 2
        org-capture-bookmark nil)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-j") 'org-next-visible-heading)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-k") 'org-previous-visible-heading)

  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-j") 'org-metadown)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-k") 'org-metaup)

  (setq org-directory "~/Nextcloud/org/")
  (setq lp/org-capture-refile (concat org-directory "Refile.org"))
  (setq lp/org-capture-mail (concat org-directory "Mail.org"))
  (setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-into-drawer t)
  (setq org-log-done 'time
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
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)")) ; Task was completed
        )
  ;; Set default column view headings: Task Total-Time Time-Stamp
  (setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")
  ;; Capture templates for: TODO tasks, Notes, meetings, etc
  (setq org-capture-templates
        (quote (("t" "todo" entry (file lp/org-capture-refile)
                 "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                ("r" "respond" entry (file lp/org-capture-refile)
                 "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
                ("i" "idea" entry (file lp/org-capture-refile)
                 "* %? :IDEA:\n%t\n" :clock-in t :clock-resume t)
                ("n" "note" entry (file lp/org-capture-refile)
                 "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
                ("g" "Meeting" entry (file lp/org-capture-refile)
                 "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
                ("p" "Phone call" entry (file lp/org-capture-refile)
                 "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t))))
  (setq org-tag-alist
        '((:startgroup)
                                        ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@work" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?P)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))

          ("W" "Work Tasks" tags-todo "+work-email")

          ;; Low-effort next actions
          ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
           ((org-agenda-overriding-header "Low Effort Tasks")
            (org-agenda-max-todos 20)
            (org-agenda-files org-agenda-files)))

          ("w" "Workflow Status"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "Waiting on External")
                   (org-agenda-files org-agenda-files)))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "In Review")
                   (org-agenda-files org-agenda-files)))
            (todo "PLAN"
                  ((org-agenda-overriding-header "In Planning")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "BACKLOG"
                  ((org-agenda-overriding-header "Project Backlog")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "READY"
                  ((org-agenda-overriding-header "Ready for Work")
                   (org-agenda-files org-agenda-files)))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "COMPLETED"
                  ((org-agenda-overriding-header "Completed Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "CANC"
                  ((org-agenda-overriding-header "Cancelled Projects")
                   (org-agenda-files org-agenda-files)))))))
  ;; (setq org-startup-indented t)
  (lp/mu4e-org-setup)
  )

(use-package org-bullets
  :straight t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))
  )

(defun lp/org-mode-visual-fill ()
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :straight t
  :hook (org-mode . lp/org-mode-visual-fill))

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("scm" . "src scheme"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)))
  (push '("conf-unix" . conf-unix) org-src-lang-modes)
  )


;; Automatically tangle our Emacs.org config file when we save it
(defun lp/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/dotfiles/home/.config/emacs.d.raw/Emacs_Conf.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'lp/org-babel-tangle-config)))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Because evil took care of C-u
(global-set-key (kbd "C-M-u") 'universal-argument)

;; (with-eval-after-load 'org
;;   (evil-define-key* 'insert org-mode-map
;;     [tab] #'indent-for-tab-command
;;     [backtab] (lambda ()
;;                 (interactive)
;;                 (indent-rigidly (line-beginning-position)
;;                                 (line-end-position)
;;                                 (- tab-width)))))
(defun +org-indent-maybe-h ()
  "Indent the current item (header or item), if possible.
 Made for `org-tab-first-hook' in evil-mode."
  (interactive)
  (cond ((not (and (bound-and-true-p evil-local-mode)
                   (or (evil-insert-state-p)
                       (evil-emacs-state-p))))
         nil)
        ((org-at-item-p)
         (if (eq this-command 'org-shifttab)
             (org-outdent-item-tree)
           (org-indent-item-tree))
         t)
        ((org-at-heading-p)
         (ignore-errors
           (if (eq this-command 'org-shifttab)
               (org-promote)
             (org-demote)))
         t)
        ((org-in-src-block-p t)
         (org-babel-do-in-edit-buffer
          (call-interactively #'indent-for-tab-command))
         t)
        ((and (save-excursion
                (skip-chars-backward " \t")
                (bolp))
              (org-in-subtree-not-table-p))
         (call-interactively #'tab-to-tab-stop)
         t)))

(add-hook 'org-cycle-tab-first-hook #'+org-indent-maybe-h)

(provide 'lp-org)
