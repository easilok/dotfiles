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

(provide 'lp-ai-config)
;;; lp-ai-config.el ends here
