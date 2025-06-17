(setq lp/mu4e-enable? nil)

(when (require 'lp-mail-configs nil 'noerror)
  (setq lp/mu4e-enable? t))

(use-package mu4e
  ;; :straight t
  :commands (mu4e lp/mu4e-org-setup mu4e-compose-new)
  ;; :defer 2
  :ensure nil
  :config
  ;; for new message view on next update
  (setq mu4e-view-use-gnus t)
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-root-maildir "~/Mail/.mumail")
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

  (when lp/mu4e-enable? (lp/mail-set-mu4e-contexts))

  (add-to-list 'mu4e-bookmarks '("(m:/personal/Inbox or m:/professional/Inbox or m:/nibble/Inbox or m:/luispereira/Inbox or m:/nibble-smtp/Inbox or m:/xyz/Inbox) and flag:unread" "Unread inbox" ?n))
  (add-to-list 'mu4e-bookmarks '("m:/personal/Inbox or m:/professional/Inbox or m:/nibble/Inbox or m:/luispereira/Inbox or m:/nibble-smtp/Inbox or m:/xyz/Inbox" "All Inboxes" ?i))


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
  (lp/leader-keys
    "om"  '(mu4e :which-key "mail"))
  )

(provide 'lp-mail)
