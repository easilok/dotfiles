;;; lp-ai-config.el --- Description -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Personal Configuration for ai in Emacs
;;
;;; Code:

(use-package! agent-shell
  :bind (:map agent-shell-mode-map
              ("RET" . newline)
              ("C-c C-c" . shell-maker-submit)
              ("C-c C-k" . agent-shell-interrupt))
  :config
  ;; Evil state-specific RET behavior: insert mode = newline, normal mode = send
  ;; (evil-define-key 'insert agent-shell-mode-map (kbd "C-c C-c") #'comint-send-input)
  (evil-define-key 'insert agent-shell-mode-map (kbd "RET") #'newline)
  (evil-define-key 'normal agent-shell-mode-map (kbd "RET") #'comint-send-input))

(use-package! agent-shell-notifications
  :hook
  ;; Enable notifications in each agent-shell buffer
  (agent-shell-mode . agent-shell-notifications-mode)
  ;; If using agent-shell-viewport, also add:
  ;; (agent-shell-viewport-edit-mode . agent-shell-notifications-viewport-edit-mode)
  ;; (agent-shell-viewport-view-mode . agent-shell-notifications-viewport-view-mode)

  :config
  ;; Notification display timeout in seconds (0 = never expire (the default), -1 = backend default)
  (setq agent-shell-notifications-timeout 8)

  ;; Seconds to wait before notifying when the shell is already visible (default: 10)
  ;; (setq agent-shell-notifications-idle-timeout 30)

  ;; Advanced filtering: suppress notifications during certain hours
  ;; (add-hook 'agent-shell-notifications-inhibit-functions
  ;;           (lambda (_type _event)
  ;;             (let ((hour (decoded-time-hour (decode-time))))
  ;;               (and (>= hour 9) (< hour 17)))))

  ;; Use the knockknock backend instead of the default libnotify
  ;; (setq agent-shell-notifications-provider 'agent-shell-notifications-knockknock)
  )


(provide 'lp-ai-config)
;;; lp-ai-config.el ends here
