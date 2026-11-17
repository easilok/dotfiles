;;; lp-dev-test.el -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Development test suite run dispatcher to term
;;
;;; Code:

(defgroup lp-dev-test nil
  "Dispatch development test suite execution into a dedicated term."
  :group 'tools)

(defcustom lp-dev-test-shell-name "*term-test*"
  "Sets the name to give for the term shell buffer used to run the test commands."
  :type 'string
  :safe #'stringp)

(defcustom lp-dev-test-command "mise test"
  "Sets the command to run for the full development test suite execution."
  :type 'string
  :safe #'stringp)

(defcustom lp-dev-test-file-command "mise test-file %s"
  "Sets the command to run for the current buffer file test suite execution."
  :type 'string
  :safe #'stringp)

(defcustom lp-dev-test-one-command "mise test-file %s -- %s"
  "Sets the command to run for the current cursor test symbol execution."
  :type 'string
  :safe #'stringp)

(defcustom lp-dev-test-split-side 'right
  "Side used to open the test terminal when a new split is required.
`right' creates a vertical split, `below' a horizontal one.  A split is
only created when the frame has no other window that can be reused."
  :type '(choice (const :tag "Right" right)
                 (const :tag "Left" left))
  :safe #'symbolp)

(defcustom lp-dev-test-term-package 'ghostel
  "Terminal emulator package used for testing runs."
  :type '(choice (const :tag "Ghostel" ghostel)
                 (const :tag "vterm" vterm))
  :safe #'symbolp)

(defun lp-dev-test--term-send-string (cmd-str)
  "Abstraction of send string to terminal emulator.
Issues CMD-STR to selected term package."
  (if (eq 'ghostel lp-dev-test-term-package)
      (ghostel-send-string cmd-str)
    (vterm-send-string cmd-str)))

(defun lp-dev-test--get-term-buffer ()
  "Ensure a term buffer exists overriding any buffer management action.
The buffer is created without being displayed so that creating it does
not move the focus away from the current window."
  (or (get-buffer lp-dev-test-shell-name)
      (let ((display-buffer-overriding-action
             (cons '(display-buffer-no-window) '((allow-no-window . t)))))
        ;; (vterm lp-dev-test-shell-name)
        (funcall lp-dev-test-term-package lp-dev-test-shell-name)
        )))

(defun lp-dev-test--ensure-term ()
  "Ensure the term buffer exists and show it in another window.
The currently selected window is never left."
  (interactive)
  (let ((term-buf (lp-dev-test--get-term-buffer)))
    (display-buffer term-buf)
    term-buf))

(defun lp-dev-test ()
  "Run full development test suite."
  (interactive)
  (let* ((cmd-template lp-dev-test-command)
         (term-buf (lp-dev-test--ensure-term)))
    (with-current-buffer term-buf
      (lp-dev-test--term-send-string (concat cmd-template "\n")))))

(defun lp-dev-test-file ()
  "Run development test suite of the current buffer file."
  (interactive)
  (let ((file (buffer-file-name)))
    (unless file
      (user-error "Current buffer is not associated with a file"))
    (let* ((cmd (format lp-dev-test-file-command
                        (shell-quote-argument file)))
           (term-buf (lp-dev-test--ensure-term)))
      (with-current-buffer term-buf
        (lp-dev-test--term-send-string (concat cmd "\n"))))))

(defun lp-dev-test-one ()
  "Run development test suite for the test named with the symbol at cursor."
  (interactive)
  (let* ((file (buffer-file-name)))
    (unless file
      (user-error "Current buffer is not associated with a file"))
    (let* ((sym (symbol-at-point)))
      (unless sym
        (user-error "No valid symbol under cursor"))
      (let* ((cmd (format lp-dev-test-one-command
                          (shell-quote-argument file)
                          (symbol-name sym)))
             (term-buf (lp-dev-test--ensure-term)))
        (with-current-buffer term-buf
          (lp-dev-test--term-send-string (concat cmd "\n")))))))

(defun lp-dev-term-buffer-rules (buffer _alist)
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

(add-to-list 'display-buffer-alist
              `((derived-mode-p ghostel-mode)
                (display-buffer-reuse-window lp-dev-term-buffer-rules)))

(add-to-list 'display-buffer-alist
              `((derived-mode-p vterm-mode)
                (display-buffer-reuse-window lp-dev-term-buffer-rules)))

(provide 'lp-dev-test)

;;; lp-dev-test.el ends here
