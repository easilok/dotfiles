;;; lp-consult-extended.el -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Custom extension to consult to include buffers filename on the search
;;
;;; Code:

(defcustom lp-consult-buffer-name-exclude
  '("\\` ")
  "Regexps matching buffer names to exclude."
  :type 'list
  :safe #'lisp)

(defcustom lp-consult-buffer-mode-exclude
  '(messages-buffer-mode)
  "List of major modes to exclude from buffer selection."
  :type 'list
  :safe #'lisp)

(defun lp--buffer-name-allowed-p (buf)
  (let ((name (buffer-name buf)))
    (not (seq-some (lambda (pattern) (string-match-p pattern name))
                   lp-consult-buffer-name-exclude))))

(defun lp--buffer-mode-allowed-p (buf)
  (with-current-buffer buf
    (not (memq major-mode lp-consult-buffer-mode-exclude))))

(defun lp-consult-buffer ()
  "Custom consult buffer switcher with buffer filenames."
  (interactive)
  (let* ((buffers (seq-filter (lambda (buf)
                                (and (lp--buffer-name-allowed-p buf)
                                     (lp--buffer-mode-allowed-p buf)))
                              (buffer-list)))
         (selections (mapcar (lambda (buf)
                               (with-current-buffer buf
                                (cons (if buffer-file-name
                                          (abbreviate-file-name buffer-file-name)
                                        (buffer-name))
                                      buf)))
                            buffers))
         (filename-buffers '())
         (other-buffers '()))


    (dolist (buf buffers)
      (with-current-buffer buf
        (if buffer-file-name
            (push (cons (propertize (abbreviate-file-name buffer-file-name) 'consult--buffer buf)
                        buf) filename-buffers)
          (push (cons (propertize (buffer-name) 'consult--buffer buf) buf) other-buffers))))


    (consult--read
     (append filename-buffers other-buffers)
     :prompt "All Buffers: "
     :require-match t
     :sort nil
     :category 'buffer
     :state (consult--buffer-state)
     :lookup #'consult--lookup-cdr)))

(defun lp-consult-project-buffer ()
  "Custom consult project buffer switcher with buffer filenames."
  (interactive)
  (let* ((persp (get-current-persp))
         (persp-buffers (when persp (persp-buffers persp)))
         (buffers (seq-filter (lambda (buf)
                                (and (lp--buffer-name-allowed-p buf)
                                     (lp--buffer-mode-allowed-p buf)))
                              persp-buffers))
         (filename-buffers '())
         (other-buffers '()))


    (dolist (buf buffers)
      (with-current-buffer buf
        (if buffer-file-name
            (push (cons (propertize (abbreviate-file-name buffer-file-name) 'consult--buffer buf)
                        buf) filename-buffers)
          (push (cons (propertize (buffer-name) 'consult--buffer buf) buf) other-buffers))))

    (consult--read
     (append filename-buffers other-buffers)
     :prompt "Project Buffers: "
     :require-match t
     :sort nil
     :category 'buffer
     :state (consult--buffer-state)
     :lookup #'consult--lookup-cdr)))

(provide 'lp-consult-extended)

;;; lp-consult-extended.el ends here
