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
(add-to-list 'default-frame-alist '(alpha-background . 90))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq doom-font (font-spec :family "Iosevka" :size 15 :weight 'normal :width 'expanded)
      doom-variable-pitch-font (font-spec :family "IosevkaAile" :size 14 :weight 'normal)
      doom-symbol-font (font-spec :family "Iosevka")
      doom-big-font (font-spec :family "Iosevka" :size 22))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(defun lp-config-fill-column ()
  (interactive)
  (set-fill-column 120)
  (display-fill-column-indicator-mode))

(add-hook 'prog-mode-hook #'lp-config-fill-column)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!


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

(when (file-directory-p "~/.config/doom/lp")
    (add-to-list 'load-path "~/.config/doom/lp")
    (require 'lp-org-config)
    (require 'lp-denote-config)
    (require 'lp-email-config)
    (require 'lp-dev-test))

(when (file-directory-p "~/.config/.emacs.priv/lp")
    (add-to-list 'load-path "~/.config/.emacs.priv/lp")
    (require 'lp-private-config nil 'noerror))

;; Buffer Keys
(map! :leader
      :desc "Switch workspace buffer"
      "b l" #'+vertico/switch-workspace-buffer
      :desc "Switch or open buffer"
      "b a" #'consult-buffer
      :desc "Switch to last buffer"
      "b b" #'evil-switch-to-windows-last-buffer
      :desc "Echo buffer filepath"
      "b f" #'lp-echo-buffer-filepath
      :desc "Close all other windows"
      "w o" #'delete-other-windows)
      

;; Jabber defined keys
(map! :leader
      :desc "Switch jabber conversation"
      "j l" #'jabber-chat-buffer-switch
      :desc "Start jabber message"
      "j m" #'jabber-chat-with
      :desc "Connect all jabber connections"
      "j c" #'jabber-connect-all)

;; Seach keys
(map! :leader
      :desc "Search symbol in project"
      "s w" #'lp-consult-project-symbol-at-point)

;; Lsp quick keybindings
(map!
 ;; :mode eglot--managed-mode
 :n "- d" #'+lookup/definition
 :n "- f" #'+format/region-or-buffer)

;; Clean some default bindings
(map!
 :leader
 "g s" nil) ;; default set to stage hunk at point)

;; Dired folder deph navigation
(after! dirvish
  (map! :map dirvish-mode-map
        :n  "DEL"   #'dired-up-directory
        :n  "h"   nil
        :n  "l"   nil))

(after! evil
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (modify-syntax-entry ?_ "w")
  ;; (setq evil-symbol-word-search nil) ;; * and # search for words not symbols
  (setq evil-respect-visual-line-mode t)
  ;; Disables global clipboard on copy/cut
  (setq select-enable-clipboard nil)
  ;; Adds C-S-c/v to copy/past from clipboard
  (map! "C-S-c" #'clipboard-kill-ring-save)
  (map! "C-S-v" #'clipboard-yank)

  (setq evil-want-fine-undo t)
  ;; (setq evil-undo-system 'undo-tree)
  ;; State change keybindings
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; quick navigation keys
  ;; (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  ;; (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  ;; (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  ;; (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  ;; Disable keys to avoid muscle memory errors
  (define-key evil-normal-state-map (kbd "C-l") nil)
  (define-key evil-normal-state-map (kbd "C-k") nil)
  (define-key evil-normal-state-map (kbd "C-j") nil)
  (map! "C-l" nil)
  (map! "C-k" nil)
  (map! "C-j" nil)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  ;; (define-key evil-insert-state-map (kbd "C-r") 'evil-past-from-register)
  (evil-ex-define-cmd "q[uit]" 'evil-window-delete))

(add-hook 'sly-mrepl-mode-hook
          (lambda ()
            (keymap-set sly-mrepl-mode-map "C-c r"
                        'comint-history-isearch-backward)))

(add-to-list 'auto-mode-alist '("\\.ctml\\'" . mhtml-mode))

(setq undo-limit 80000                         ; Raise undo-limit to 80KB
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(setq display-time-24hr-format t)
(setq display-time-format "%H:%M - %d %b (W%W)")
(display-time-mode 1)

(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                       ; On laptops it's nice to know how much power you have

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)
(setq visible-bell t)

;; Tab will always ident the line the cursor is at
(setq-default indent-tabs-mode nil) ; for converting tabs to spaces on identation
(setq-default tab-always-indent t)

(add-hook 'jabber-chat-mode-hook #'visual-line-mode)
(remove-hook 'jabber-alert-message-hooks #'jabber-message-echo)
(remove-hook 'jabber-alert-muc-hooks #'jabber-muc-echo)
(remove-hook 'jabber-alert-presence-hooks #'jabber-presence-echo)

(after! eglot
  :config
  (set-eglot-client! '(python-mode python-ts-mode)
                     '("basedpyright" "--stdio")
                     '("basedpyright-langserver" "--stdio")
                     '("pyright-langserver" "--stdio")
                     '("pyright" "--stdio")
                     '("ruff" "server")
                     "pylsp" "pyls"
                     "ruff-lsp"))

(add-hook 'python-mode-hook #'mise-mode)
(add-hook 'python-ts-mode-hook #'mise-mode)
(add-hook 'typescript-mode-hook #'mise-mode)
(add-hook 'typescript-ts-mode-hook #'mise-mode)
(add-hook 'prog-mode-hook #'breadcrumb-local-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(after! doom-modeline
  (setq doom-modeline-modal-icon nil) ;; vim modes
  (setq doom-modeline-buffer-file-name-style 'truncate-except-project))


(defun lp-search-project-symbol-at-point ()
  (interactive)
  (project-find-regexp (thing-at-point 'symbol t)))

(defun lp-consult-project-symbol-at-point ()
  (interactive)
  (let ((consult-ripgrep-args (concat consult-ripgrep-args " --hidden")))
    (consult-ripgrep (project-root (project-current))
                     (thing-at-point 'symbol t))))

(defun lp-echo-buffer-filepath ()
  (interactive)
  (message (buffer-file-name)))

;; (use-package! pinentry
;;   :init (setq epa-pinentry-mode 'loopback)
;;   (pinentry-start))

;; doom's `persp-mode' disables uniquify, as it causes some issues when switching workspaces.
;; I'm trying to  override it for better buffer navigatio..
;; `persp-mode' is activated in the `doom-init-ui-hook',
;; so this new hook at at the end of the list of hooks should prevail my options.
(defun lp-set-buffer-autonaming-h ()
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'forward))

(add-hook! 'doom-init-ui-hook
           :append ;; ensure it gets added to the end.
           #'lp-set-buffer-autonaming-h)

;; Stealing from Fade
(use-package! beacon
  :config
  (beacon-mode 1))
