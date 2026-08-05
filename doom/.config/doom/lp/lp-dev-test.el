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

;; (defun lp-dev-test--ensure-vterm ()
;;   "Ensures that a vterm instance exists with the provided configuration."
;;   (let ((vterm-buf (get-buffer lp-dev-test-shell-name)))
;;     (unless vterm-buf
;;       (setq vterm-buf (vterm lp-dev-test-shell-name)))
;;     vterm-buf))

(defun lp-dev-test--get-vterm-buffer ()
  "Ensure a vterm buffer exists overriding any buffer management action."
  (or (get-buffer lp-dev-test-shell-name)
      (let ((display-buffer-overriding-action
             '((display-buffer-no-window))))
        (vterm lp-dev-test-shell-name))))

(defun lp-dev-test--ensure-vterm ()
  "Ensure the vterm buffer exists and show it in the other window."
  (let ((vterm-buf (lp-dev-test--get-vterm-buffer)))
    (if-let ((window (get-buffer-window vterm-buf t)))
        (select-window window)
      (other-window 1)
      (switch-to-buffer vterm-buf))
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
