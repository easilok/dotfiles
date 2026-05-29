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

(defun lp--tab-buffers ()
  "Return live buffers recorded in the selected tab's buffer lists."
  (let* ((buffers (frame-parameter nil 'buffer-list))
         (buried-buffers (frame-parameter nil 'buried-buffer-list)))
    (seq-uniq
     (seq-filter (lambda (buf)
                   (and (buffer-live-p buf)
                        (not (minibufferp buf))))
                 (append buffers buried-buffers))
     #'eq)))


(defun lp--tab-buffer-names ()
  "Return names of buffers recorded in the selected tab."
  (mapcar #'buffer-name (lp--tab-buffers)))

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
  (if (project-current)
      (call-interactively #'project-switch-to-buffer)
    (let* (
           ;; (persp (get-current-persp))
           ;; (persp-buffers (when persp (persp-buffers persp)))
           (persp-buffers (lp--tab-buffers))
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
       :lookup #'consult--lookup-cdr))))


(defun lp-tab-switch-buffer ()
  "Switch to a buffer recorded in the selected tab."
  (interactive)
  (let ((buffers (lp--tab-buffers)))
    (unless buffers
      (user-error "No buffers are recorded in the current tab"))
    (let ((names (lp--tab-buffer-names)))
      (minibuffer-with-setup-hook
          (lambda ()
            (setq-local minibuffer-completion-table names))
        (switch-to-buffer
         (read-buffer "Tab buffer: " (other-buffer (current-buffer))
                      (confirm-nonexistent-file-or-buffer)))))))

(defun lp-tab-consult-switch-buffer ()
  "Use `consult' to switch to a buffer recorded in the selected tab."
  (interactive)
  (require 'consult)
  (let ((buffers (lp--tab-buffers)))
    (unless buffers
      (user-error "No buffers are recorded in the current tab"))
    (let ((consult-buffer-list-function (lambda () buffers)))
      (consult-buffer))))

(provide 'lp-consult-extended)

;;; lp-consult-extended.el ends here
