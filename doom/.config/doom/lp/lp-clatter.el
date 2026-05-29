;;; lp-clatter.el -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Personal CLatter configuration
;;
;;; Code:

(defun lp-clatter-in-input-area-p ()
  (and (>= (point) clatter--input-marker)
       (< (point) clatter--messages-marker)))

(defun lp-clatter-evil-insert ()
  (interactive)
  (if (derived-mode-p 'clatter-mode)
      (if (lp-clatter-in-input-area-p)
          (evil-insert 0)
        (progn
         (goto-char clatter--input-marker)
         (evil-append nil)))
    (evil-insert 0)))

(defun lp-clatter-evil-append ()
  (interactive)
  (lp-clatter-evil-insert))

(defun lp-clatter-evil-append-line ()
  (interactive)
  (when (derived-mode-p 'clatter-mode)
    (unless (lp-clatter-in-input-area-p)
      (goto-char clatter--input-marker)))
  (evil-append-line nil))

(with-eval-after-load 'evil
  (evil-define-key 'normal clatter-mode-map
    (kbd "i") #'my-clatter-evil-insert
    (kbd "a") #'my-clatter-evil-append))

(when (file-directory-p "~/git/clatter.el/")
  (add-to-list 'load-path "~/git/clatter.el")
  (require 'clatter)
  (require 'gnutls)

  (setq clatter-networks
        '(("libera"
           :server "irc.libera.chat"
           :port 6697
           :tls t
           :nick "easilokx"
           ;; :sasl scram-sha-256  ;; or 'plain or 'external
           :autojoin ("#clatter" "#asteroid.music"))))

  (with-eval-after-load 'evil
    (evil-define-key 'normal clatter-mode-map
      (kbd "i") #'lp-clatter-evil-insert
      (kbd "a") #'lp-clatter-evil-append
      (kbd "A") #'lp-clatter-evil-append-line))

  (global-set-key (kbd "C-c i i") #'clatter)
  (global-set-key (kbd "C-c i d") #'clatter-disconnect)
  (global-set-key (kbd "C-c i t") #'clatter-track-switch)
  (global-set-key (kbd "C-c i l") #'clatter-track-list))

(provide 'lp-clatter)

;;; lp-clatter.el ends here
