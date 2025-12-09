;;; lp-email-config.el --- Description -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Personal Configuration for email in Emacs
;;
;;; Code:

(defvar lp-email-extra? nil)

(defvar lp-contexts-available '())

;; Email context file should build the lp-contexts-available variable
;; which is a alist of type '((maildir . context))
;;
;; Example:
;;
;; (setq lp-contexts-available
;;       `(("personal" . ,(make-mu4e-context
;;                         :name "Personal"
;;                         :match-func (lambda (msg)
;;                                       (when msg
;;                                         (string-prefix-p "/personal" (mu4e-message-field msg :maildir))))
;;                         :vars '((user-mail-address . "personal@example.org")
;;                                 (user-full-name    . "Luis Pereira")
;;                                 (mu4e-drafts-folder  . "/personal/Drafts")
;;                                 (mu4e-sent-folder  . "/personal/Sent")
;;                                 (mu4e-refile-folder  . "/personal/Archive")
;;                                 (mu4e-trash-folder  . "/personal/Trash"))))))
;;
(defun lp-set-mu4e-contexts ()
  (let* ((root-maildirs (file-name-as-directory mu4e-root-maildir))
         (contexts
          (cl-loop for (mail-name . context) in lp-contexts-available
                   for maildir = (expand-file-name mail-name root-maildirs)
                   when (file-directory-p maildir)
                   collect context)))
  (setq mu4e-contexts contexts)))

(use-package! mu4e
  ;; :straight t
  :commands (mu4e lp-mu4e-org-setup mu4e-compose-new)
  :ensure nil
  :config
  (when (require 'lp-email-contexts nil 'noerror)
    (setq lp-email-extra? t))

  ;; for new message view on next update
  (setq mu4e-view-use-gnus t)
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-root-maildir "~/Mail/.mumail")
  (setq mu4e-compose-context-policy 'always-ask)
  (setq mu4e-context-policy 'pick-first)

  ;; enable inline images
  (setq mu4e-view-show-images t)
  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
  (setq browse-url-browser-function 'browse-url-generic)
  ;; (setq browse-url-generic-program "qutebrowser")
  ;; From Doom - Html mails might be better rendered in a browser
  (add-to-list 'mu4e-view-actions
               '("View in browser" . mu4e-action-view-in-browser))
  (add-to-list 'mu4e-view-actions
              '("viewInBrowser" . mu4e-action-view-in-browser) t)

  (when lp-email-extra? (lp-set-mu4e-contexts))

  (add-to-list 'mu4e-bookmarks '("(m:/personal/Inbox or m:/professional/Inbox or m:/xyz/Inbox or m:/box/Inbox) and flag:unread" "Unread inbox" ?n))
  (add-to-list 'mu4e-bookmarks '("m:/personal/Inbox or m:/professional/Inbox or m:/xyz/Inbox or m:/box/Inbox" "All Inboxes" ?i))


  (setq mu4e-headers-time-format "%H:%M")
  ;; the headers to show in the headers list -- a pair of a field
  ;; and its width, with `nil' meaning 'unlimited'
  ;; better only use that for the last field.
  ;; These are the defaults:
  (setq mu4e-headers-fields
        '((:date    . 15)    ;; alternatively, use :human-date
          (:flags   .  8)
          (:from    . 22)
          (:maildir . 20)
          (:subject . nil))) ;; alternatively, use :thread-subject

  ;; smtp mail setting
  ;; use mu4e for e-mail in emacs
  (setq mail-user-agent 'mu4e-user-agent)
  (setq mu4e-compose-format-flowed t)
  (setq message-send-mail-function 'smtpmail-send-it)
  (map! :leader
        :desc "Open email"
        "o m" #'mu4e))


(provide 'lp-email-config)
;;; lp-email-config.el ends here
