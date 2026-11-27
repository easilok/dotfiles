;;; lp-window-config.el --- Description -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Personal Configuration for window placements in Emacs
;;
;;; Code:

(defun lp-window-enforce-vertical-split (buffer _alist)
  "Display BUFFER in another window or create a side window."
  (if (>= (count-windows) 2)
      (display-buffer-use-some-window
       buffer
       '((inhibit-same-window . t)))
    (display-buffer-in-side-window
     buffer
     '((side . right)
       (slot . 0)
       (inhibit-same-window . t)
       (window-width . 0.5)))
    ;; (display-buffer-in-direction
    ;;  buffer
    ;;  '((side . right)
    ;;    (inhibit-same-window . t)
    ;;    (window-width . 0.5)))
    ))

(defun lp-window-bottom-popup (buffer _alist)
  "Display BUFFER in a bottom popup window."
  (display-buffer-in-side-window
   buffer
   '((dedicated . t)
     (side . bottom)
     (slot . 0)
     (window-parameters . ((mode-line-format . none))))))

(setq display-buffer-alist
      `(;; no window
        ("\\`\\*Async Shell Command\\*\\'"
         (display-buffer-no-window))
        ("\\`\\*\\(Warnings\\|Compile-Log\\|Org Links\\)\\*\\'"
         (display-buffer-no-window)
         (allow-no-window . t))
        ;; bottom side window
        ("\\*\\(Org \\(Select\\|Note\\)\\|Agenda Commands\\|Calendar\\)\\*" ; the `org-capture' key selection and `org-add-log-note'
         (lp-window-bottom-popup))
        ((or (derived-mode-p compilation-mode)
             "^\\*compilation"
         (lp-window-bottom-popup)))))

(after! ghostel
  (add-to-list 'display-buffer-alist
               `((derived-mode-p ghostel-mode)
                 (display-buffer-reuse-window lp-window-enforce-vertical-split))))

(after! vterm
  (add-to-list 'display-buffer-alist
               `((derived-mode-p vterm-mode)
                 (display-buffer-reuse-window lp-window-enforce-vertical-split))))

(provide 'lp-window-config)
;;; lp-window-config.el ends here
