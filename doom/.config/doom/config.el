;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")
(setq user-full-name "Luis Pereira"
    user-mail-address "luispereira.tkd@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(set-frame-parameter nil 'alpha-background 90)


(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(if (file-directory-p "~/Nextcloud/org")
  (setq org-directory "~/Nextcloud/org")
  (setq org-directory "~/Documents/org"))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(when (file-directory-p "~/git/LASS/")
    (add-to-list 'load-path "~/git/LASS/")
    (require 'lass))

;; https://github.com/glenneth1/crafterbin.el.git
(when (file-directory-p "~/git/crafterbin.el")
    (add-to-list 'load-path "~/git/crafterbin.el")
    (require 'crafterbin))

(map! :leader
      :desc "Switch workspace buffer"
      "b l" #'+vertico/switch-workspace-buffer
      :desc "Switch to last buffer"
      "b l" #'evil-switch-to-windows-last-buffer)

(map!
 ;; :mode eglot--managed-mode
 :n "- d" #'+lookup/definition)



(after! evil
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (modify-syntax-entry ?_ "w")
  (setq evil-symbol-word-search nil) ;; * and # search for words not symbols
  (setq evil-respect-visual-line-mode t)
  (setq select-enable-clipboard nil) ;; This is for disabling global clipboard on copy/cut
  (setq evil-want-fine-undo t)
  ;; (setq evil-undo-system 'undo-tree)
  ;; State change keybindings
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; quick navigation keys
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  ;; (define-key evil-insert-state-map (kbd "C-r") 'evil-past-from-register)
  (evil-ex-define-cmd "q[uit]" 'evil-window-delete))

(setq undo-limit 80000                         ; Raise undo-limit to 80KB
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(setq display-time-24hr-format t)
(setq display-time-format "%H:%M - %d %B (%W)")
(display-time-mode 1)

(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                       ; On laptops it's nice to know how much power you have

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)
(setq visible-bell t)

;; (add-hook 'after-init-hook #'global-mise-mode)
;; CLI tools installed by Mise
;; See: https://www.emacswiki.org/emacs/ExecPath
(when (file-directory-p "~/.local/share/mise/shims")
  (setenv "PATH" (concat (getenv "PATH") ":~/.local/share/mise/shims"))
  (setq exec-path (append exec-path '("~/.local/share/mise/shims"))))

;; Tab will always ident the line the cursor is at
(setq tab-always-indent nil) ;; Also set in custom variables
