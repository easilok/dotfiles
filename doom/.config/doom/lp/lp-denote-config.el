;;; lp-denote-config.el -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Personal Configuration for Denote
;;
;;; Code:

(defun lp-denote--get-root-dir ()
  (if (file-directory-p "~/Nextcloud/denote")
      "~/Nextcloud/denote"
    "~/Documents/denote"))

(use-package! denote
       ;; :ensure t
       :after ('org)
       :hook
       ( ;; If you use Markdown or plain text files, then you want to make
        ;; the Denote links clickable (Org renders links as buttons right
        ;; away)
        (text-mode . denote-fontify-links-mode-maybe)
        ;; Apply colours to Denote names in Dired.  This applies to all
        ;; directories.  Check `denote-dired-directories' for the specific
        ;; directories you may prefer instead.  Then, instead of
        ;; `denote-dired-mode', use `denote-dired-mode-in-directories'.
        (dired-mode . denote-dired-mode))
       :bind
       ;; Denote DOES NOT define any key bindings.  This is for the user to
       ;; decide.  For example:
       ( :map global-map
         ("C-c n n" . denote)
         ("C-c n d" . denote-dired)
         ("C-c n g" . denote-grep)
         ;; If you intend to use Denote with a variety of file types, it is
         ;; easier to bind the link-related commands to the `global-map', as
         ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
         ;; `markdown-mode-map', and/or `text-mode-map'.
         :map org-mode-map
         ("C-c n l" . denote-link)
         ("C-c n L" . denote-add-links)
         ("C-c n b" . denote-backlinks)
         ("C-c n q c" . denote-query-contents-link) ; create link that triggers a grep
         ("C-c n q f" . denote-query-filenames-link) ; create link that triggers a dired
         ;; Note that `denote-rename-file' can work from any context, not just
         ;; Dired buffers.  That is why we bind it here to the `global-map'.
         ("C-c n r" . denote-rename-file)
         ("C-c n R" . denote-rename-file-using-front-matter)

         ;; Key bindings specifically for Dired.
         :map dired-mode-map
         ("C-c C-d C-i" . denote-dired-link-marked-notes)
         ("C-c C-d C-r" . denote-dired-rename-files)
         ("C-c C-d C-k" . denote-dired-rename-marked-files-with-keywords)
         ("C-c C-d C-R" . denote-dired-rename-marked-files-using-front-matter))

       :config
       ;; Remember to check the doc string of each of those variables.
       (setq denote-directory (expand-file-name (lp-denote--get-root-dir)))
       (setq denote-save-buffers nil)
       (setq denote-known-keywords '("emacs" "asteroid" "lisp"))
       (setq denote-infer-keywords t)
       (setq denote-sort-keywords t)
       (setq denote-prompts '(file-type title keywords subdirectory))
       ;; (setq denote-excluded-directories-regexp nil)
       ;; (setq denote-keywords-to-not-infer-regexp nil)
       (setq denote-rename-confirmations '(rewrite-front-matter modify-file-name))

       ;; Pick dates, where relevant, with Org's advanced interface:
       (setq denote-date-prompt-use-org-read-date t)

       ;; Delete unused denote file types from allowed list
       (assoc-delete-all 'text denote-file-types)
       (assoc-delete-all 'markdown-toml denote-file-types)

       ;; Automatically rename Denote buffers using the `denote-rename-buffer-format'.
       (denote-rename-buffer-mode 1))

(provide 'lp-denote-config)
;;; lp-denote-config.el ends here
