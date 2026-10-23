;;; lp-dev-test.el -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Development test suite run dispatcher to vterm
;;
;;; Code:

(defgroup lp-dev-test nil
  "Dispatch development test suite execution into a dedicated vterm."
  :group 'tools)

(defcustom lp-dev-test-shell-name "*vterm-test*"
  "Sets the name to give for the vterm shell buffer used to run the test commands."
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
  :type '(choice (const :tag "Right (vertical)" right)
                 (const :tag "Below (horizontal)" below))
  :safe #'symbolp)

(defun lp-dev-test--get-vterm-buffer ()
  "Ensure a vterm buffer exists overriding any buffer management action.
The buffer is created without being displayed so that creating it does
not move the focus away from the current window."
  (or (get-buffer lp-dev-test-shell-name)
      (let ((display-buffer-overriding-action
             (cons '(display-buffer-no-window) '((allow-no-window . t)))))
        (vterm lp-dev-test-shell-name))))

(defun lp-dev-test--reusable-window-p (window)
  "Return non-nil when WINDOW can be used for the test terminal.
The selected window, dedicated windows and side windows are excluded."
  (and (not (eq window (selected-window)))
       (not (window-dedicated-p window))
       (null (window-parameter window 'window-side))))

(defun lp-dev-test--display-buffer (buffer _alist)
  "Display BUFFER in another window without selecting it.
Reuse the window already showing BUFFER when there is one, otherwise
reuse the next reusable window of the frame and, failing that, split the
selected window according to `lp-dev-test-split-side'.  The selected
window always keeps the focus."
  (let ((window (or (get-buffer-window buffer t)
                    (seq-find #'lp-dev-test--reusable-window-p
                              (cdr (window-list nil 'no-mini))))))
    (unless window
      (setq window (if (eq lp-dev-test-split-side 'below)
                       (split-window-below)
                     (split-window-right))))
    (set-window-buffer window buffer)
    window))

(defun lp-dev-test--ensure-vterm ()
  "Ensure the vterm buffer exists and show it in another window.
The currently selected window is never left."
  (let ((vterm-buf (lp-dev-test--get-vterm-buffer)))
    (display-buffer vterm-buf '((lp-dev-test--display-buffer)))
    vterm-buf))

(defun lp-dev-test ()
  "Run full development test suite."
  (interactive)
  (let* ((cmd-template lp-dev-test-command)
         (vterm-buf (lp-dev-test--ensure-vterm)))
    (with-current-buffer vterm-buf
      (vterm-send-string (concat cmd-template "\n")))))

(defun lp-dev-test-file ()
  "Run development test suite of the current buffer file."
  (interactive)
  (let ((file (buffer-file-name)))
    (unless file
      (user-error "Current buffer is not associated with a file"))
    (let* ((cmd (format lp-dev-test-file-command
                        (shell-quote-argument file)))
           (vterm-buf (lp-dev-test--ensure-vterm)))
      (with-current-buffer vterm-buf
        (vterm-send-string (concat cmd "\n"))))))

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
             (vterm-buf (lp-dev-test--ensure-vterm)))
        (with-current-buffer vterm-buf
          (vterm-send-string (concat cmd "\n")))))))

(provide 'lp-dev-test)

;;; lp-dev-test.el ends here
