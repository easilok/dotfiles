;; The default is 800 kilobytes.  Measured in bytes.
;; (setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(set-default-coding-systems 'utf-8)

;;; variable for global font size
(defvar efs/default-font-size 100)
(defvar efs/default-variable-font-size 115)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(dolist (mode '(term-mode-hook
                eshell-mode-hook
                ))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(column-number-mode)

(set-face-attribute 'default nil :font "Source Code Pro" :height efs/default-font-size)
(setq frame-resize-pixelwise t)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Source Code Pro" :height efs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;; (setq use-package-verbose t)

;; Add my library path to load-path
(push "~/.emacs.d/myLibs" load-path)

;; M-x all-the-icons-install-fonts
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; (display-time-mode 1) ;; Enable time in the mode-line
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1)) ; On laptops it's nice to know how much power you have

(use-package doom-themes
  :init (load-theme 'doom-one t))

(setq indent-tabs-mode nil) ; for converting tabs to spaces on identation
(setq-default evil-shift-width tab-width)
(setq tab-width 4) ; or any other preferred value
(setq org-src--tab-width tab-width)


(use-package command-log-mode
  :commands global-console-log-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(setq undo-limit 80000                         ; Raise undo-limit to 80KB
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space
(setq max-list-eval-depth 400) ; trying to fix c stack overflow error. Was 800
(setq max-specpdl-size 800) ; trying to fix c stack overflow error. Was 1600

(use-package perspective
  :config
  (persp-mode))

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
;(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; Org Mode Configuration ------------------------------------------------------

(defun efs/org-font-setup ()
  (with-eval-after-load 'org
    ;; Set faces for heading levels
    (dolist (face '((org-level-1 . 1.2)
                    (org-level-2 . 1.1)
                    (org-level-3 . 1.05)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
      (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))
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
    (setq org-imenu-depth 8)
    ;; Sub-lists should have different bullets
    (setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a.")))
    ))

(with-eval-after-load 'org-faces
  (efs/org-font-setup))

;; (font-lock-add-keywords
;;  'org-mode
;;  `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)" 1 'org-headline-done prepend))
;;  'append)

(defun efs/org-mode-setup ()
  (org-indent-mode)
  ;; (variable-pitch-mode)
  ;; (auto-fill-mode 0)
  (visual-line-mode 1)
  ;; (setq evil-auto-indent nil)
  )


(defun efs/capture-mail-follow-up (msg)
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "mf"))

(defun efs/capture-mail-read-later (msg)
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "mr"))

;; add :immediate-finish t at the end of each entry to void confirmation
(defun efs/mu4e-org-setup()
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
                     '("follow up" . efs/capture-mail-follow-up) t)
        (add-to-list 'mu4e-view-actions
                     '("follow up" . efs/capture-mail-follow-up) t)
        (add-to-list 'mu4e-headers-actions
                     '("read later" . efs/capture-mail-read-later) t)
        (add-to-list 'mu4e-view-actions
                     '("read later" . efs/capture-mail-read-later) t)
)

  (use-package org
    :pin org
    :hook (org-mode . efs/org-mode-setup)
    :config
    (setq-default org-adapt-indentation t)
    (setq org-ellipsis " ▾")
    (setq org-directory "~/nextcloud/org/")
    (setq lp/org-capture-refile (concat org-directory "Refile.org"))
    (setq lp/org-capture-mail (concat org-directory "Mail.org"))
    (setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))

    (setq org-agenda-start-with-log-mode t)
    (setq org-log-into-drawer t)
    (setq org-log-done 'time
          org-journal-dir "~/nextcloud/org/journal/"
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
    (setq org-startup-folded 'content)
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
    (efs/mu4e-org-setup)
    )

  (use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    ;;:custom
    ;;(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))
    )

  (defun efs/org-mode-visual-fill ()
    (setq visual-fill-column-width 120
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))

  (use-package visual-fill-column
    :hook (org-mode . efs/org-mode-visual-fill))

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
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/dotfiles/home/.config/emacs.d.raw/Emacs_Conf.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Because evil took care of C-u
(global-set-key (kbd "C-M-u") 'universal-argument)

(setq tab-always-indent nil)

(use-package general
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "M-SPC")

  (efs/leader-keys
    "SPC"  '(counsel-projectile-find-file :which-key "Projectile find file")
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "o"  '(:ignore t :which-key "open")
    "om"  '(mu4e :which-key "mail")
    "og"  '(magit-status :which-key "magit")
    "f"  '(:ignore t :which-key "file")
    "ff"  '(counsel-find-file :which-key "find file")
    "fp"  '(counsel-find-file "~/.emacs.d" :which-key "find configs")
    "fr"  '(counsel-recentf :which-key "find recent")
    "b"  '(:ignore t :which-key "buffer")
    ;;"bb"  '(counsel-projectile-switch-to-buffer :which-key "switch project buffer")
    ;; "bb"  '(switch-workspace-buffer :which-key "switch project buffer")
    "bb"  '(projectile-switch-to-buffer :which-key "switch project buffer")
    "bB"  '(counsel-switch-buffer :which-key "switch buffer")
    "bk"  '(kill-current-buffer :which-key "kill buffer")
    "bd"  '(kill-buffer :which-key "kill a buffer")
    "bi"  '(ibuffer :which-key "ibuffer")
    "p"  '(:ignore t :which-key "project")
    ;; "pm"  '(:keymap projectile-command-map :which-key "projectile")
    "pp"  '(projectile-switch-project :which-key "open project")
    ))

(use-package evil
       :init
       (setq evil-want-integration t)
       (setq evil-want-keybinding nil)
       (setq evil-want-C-u-scroll t)
       (setq evil-want-fine-undo t)
       (setq evil-want-C-i-jump nil)
       (setq evil-undo-system 'undo-tree)
       :config
       (evil-mode 1)
       (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
       (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

       ;; Use visual line motions even outside of visual-line-mode buffers
       (evil-global-set-key 'motion "j" 'evil-next-visual-line)
       (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

       (evil-set-initial-state 'messages-buffer-mode 'normal)
       (evil-set-initial-state 'dashboard-mode 'normal))

     (use-package undo-tree
       :after evil
       :config
       (global-undo-tree-mode 1))

     (use-package evil-collection
       :after evil
       :config
       (evil-collection-init))

     (use-package evil-commentary
       :after evil
       :config
       (evil-commentary-mode))

     (use-package evil-surround
       :after evil
       :config
       (global-evil-surround-mode 1))

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

(add-hook 'org-tab-first-hook #'+org-indent-maybe-h)

(use-package which-key
  :after ivy 
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode))

;; (use-package counsel
;;   :after ivy
;;   :bind (("M-x" . counsel-M-x)
;;          ("C-x b" . counsel-ibuffer)
;;          ("C-x C-f" . counsel-find-file)
;;          :map minibuffer-local-map
;;          ("C-r" . 'counsel-minibuffer-history)))

(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x)
         ("C-M-j" . 'counsel-switch-buffer)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         ("C-M-j" . counsel-switch-buffer)
         ("C-M-l" . counsel-imenu)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (setq ivy-initial-inputs-alist nil) ;; Don't start searches with ^
  ;; (counsel-mode 1)
  )

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))
  ;:config
  ;(ivy-set-display-transformer 'ivy-switch-buffer
  ;                             'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :after ivy)

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(defun efs/lsp-mode-setup ()
    (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
    (lsp-headerline-breadcrumb-mode))

  (use-package lsp-mode
    :commands (lsp lsp-deferred)
    :hook (lsp-mode . efs/lsp-mode-setup)
    :init
    (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
    :config
    (lsp-enable-which-key-integration t))
    (setq lsp-enable-snippet nil)
    (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error"))

(efs/leader-keys
  "l"  '(:ignore t :which-key "lsp")
  "ld" 'xref-find-definitions
  "lr" 'xref-find-references
  "ln" 'lsp-ui-find-next-reference
  "lp" 'lsp-ui-find-prev-reference
  "ls" 'counsel-imenu
  "le" 'lsp-ui-flycheck-list
  "lS" 'lsp-ui-sideline-mode
  "lX" 'lsp-execute-code-action)

(use-package lsp-ui
      :hook (lsp-mode . lsp-ui-mode)
      :custom
      (lsp-ui-doc-position 'bottom))

    (use-package lsp-ivy
      :commands (lsp lsp-deferred))

(use-package flycheck
        :defer t
        :hook (lsp-mode . flycheck-mode))

(use-package lsp-treemacs
  :after lsp)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("TAB" . company-complete-selection))
        ;; (:map lsp-mode-map
        ;;  ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.0))

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;;(use-package evil-magit
;;  :after magit)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :general
  (efs/leader-keys
    "pm"  '(:keymap projectile-command-map :which-key "projectile")
  )
  ;;:init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  ;;(when (file-directory-p "~/Projects/Code")
  ;;  (setq projectile-project-search-path '("~/Projects/Code")))
  ;;(setq projectile-switch-project-action #'projectile-dired))
  )

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package nvm
   :defer t)
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(defun dw/set-js-indentation ()
  (setq js-indent-level 2)
  (setq evil-shift-width js-indent-level)
  (setq-default tab-width 2))

(use-package js2-mode
  :hook (js2-mode . lsp-deferred)
  :mode "\\.jsx?\\'"
  :config
  ;; Use js2-mode for Node scripts
  (add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))

  ;; Don't use built-in syntax checking
  (setq js2-mode-show-strict-warnings nil)

  ;; Set up proper indentation in JavaScript and JSON files
  (add-hook 'js2-mode-hook #'dw/set-js-indentation)
  (add-hook 'json-mode-hook #'dw/set-js-indentation))

(use-package prettier-js
  :hook ((js2-mode . prettier-js-mode)
         (typescript-mode . prettier-js-mode))
  :config
  (setq prettier-js-show-errors nil))

(use-package web-mode
    :hook (web-mode . lsp)
    :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\|vue\\)\\'"
    :config
    (setq-default web-mode-code-indent-offset 2)
    (setq-default web-mode-markup-indent-offset 2)
    (setq-default web-mode-attribute-indent-offset 2))

(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(use-package lsp-tailwindcss
   :after lsp)

(add-hook 'scss-mode-hook 'lsp)
(add-hook 'css-mode-hook 'lsp)

;; (use-package ccls
;;   :after lsp-mode
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp))))

(use-package irony
      :commands (irony-mode)
    )

  (use-package company-irony
     :after irony
   )

  ;; Use irony's completion functions.
  (add-hook 'irony-mode-hook
            (lambda ()
              (define-key irony-mode-map [remap completion-at-point]
                'irony-completion-at-point-async)

              (define-key irony-mode-map [remap complete-symbol]
                'irony-completion-at-point-async)

              (irony-cdb-autosetup-compile-options)))

(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))
    (use-package platformio-mode
      :hook (c++-mode .
             (lambda()
               (irony-mode)
               ;; (irony-eldoc) 
               (platformio-conditionally-enable))))

;; (add-hook 'emacs-lisp-mode-hook #'flycheck-mode)

(use-package python-mode
  :ensure nil
  :hook
  ;; (python-mode . lsp-deferred)
  (python-mode . pyvenv-mode)
  ;; (python-mode . flycheck-mode)
  (python-mode . company-mode)
  ;; (python-mode . blacken-mode)
  ;; (python-mode . yas-minor-mode)
  ;; :custom
  ;; (dap-python-debugger 'debugpy)
  ;; :config
  ;; (require 'dap-python)
  )

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))  ; or lsp-deferred
(use-package pyvenv
  :config
  (pyvenv-mode t)

  ;; Set correct Python interpreter
  (setq pyvenv-post-activate-hooks
        (list (lambda ()
                (setq python-shell-interpreter (concat pyvenv-virtual-env "bin/python")))))
  (setq pyvenv-post-deactivate-hooks
        (list (lambda ()
                (setq python-shell-interpreter "python")))))

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package php-mode
  :mode "\\.php$"
  :hook (php-mode . lsp-deferred))

(require 'lp-mail)

(use-package mu4e
  ;; :commands (mu4e efs/mu4e-org-setup mu4e-compose-new)
  :defer 2
  :ensure nil
  :config
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-root-maildir "/mnt/coisas/.mumail")
  (setq mu4e-compose-context-policy 'always-ask)
  (setq mu4e-context-policy 'pick-first)

  ;; enable inline images
  (setq mu4e-view-show-images t)
  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "qutebrowser")
  ;; (add-to-list 'mu4e-view-actions
  ;;              '("viewInBrowser" . mu4e-action-view-in-browser) t)

  ;; From Doom - Html mails might be better rendered in a browser
  (add-to-list 'mu4e-view-actions '("View in browser" . mu4e-action-view-in-browser))

  (lp/mail-set-mu4e-contexts)

  (add-to-list 'mu4e-bookmarks '("(m:/personal/Inbox or m:/professional/Inbox or m:/nibble/Inbox) and flag:unread" "Unread inbox" ?n))
  (add-to-list 'mu4e-bookmarks '("m:/personal/Inbox or m:/professional/Inbox or m:/nibble/Inbox" "All Inboxes" ?i))


  (setq mu4e-headers-time-format "%H:%M")
  ;; the headers to show in the headers list -- a pair of a field
  ;; and its width, with `nil' meaning 'unlimited'
  ;; better only use that for the last field.
  ;; These are the defaults:
  (setq mu4e-headers-fields
        '( (:date          .  15)    ;; alternatively, use :human-date
           (:flags         .   8)
           (:from          .  22)
           (:maildir       . 20)
           (:subject       .  nil))) ;; alternatively, use :thread-subject

  ;; smtp mail setting
  ;; use mu4e for e-mail in emacs
  (setq mail-user-agent 'mu4e-user-agent)
  (setq mu4e-compose-format-flowed t)
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "qutebrowser")
  (add-to-list 'mu4e-view-actions
               '("viewInBrowser" . mu4e-action-view-in-browser) t)
  )

(use-package org-mime
  :after mu4e)

(setq org-mime-export-options '(:section-numbers nil
                                :with-author nil
                                :with-toc nil))

(add-hook 'org-mime-html-hook
          (lambda ()
            (org-mime-change-element-style
            "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
                          "#E6E1DC" "#232323"))))

;; (add-hook 'message-send-hook 'org-mime-htmlize)

;; (add-hook 'message-send-hook 'org-mime-confirm-when-no-multipart)

;; (defun lp/org-msg-mode-mu4e ()
;;   "Setup the hook for mu4e mail user agent."
;;   (if org-msg-mode
;;       (add-hook 'mu4e-compose-mode-hook 'org-msg-post-setup)
;;       (remove-hook 'mu4e-compose-mode-hook 'org-msg-post-setup)))
;; (use-package org-msg
;;   :commands (mu4e-compose-new compose-mail)
;;   :config
;;   (lp/org-msg-mode-mu4e)
;;   (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t")
;;   (org-msg-mode)
;;   )

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

;; Set default connection mode to SSH
(setq tramp-default-method "ssh")

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-ahgo --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))


