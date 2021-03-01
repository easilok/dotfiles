;; -*- mode: guix-scheme -*-

(specifications->manifest
 '(
   ;; wm / xtools
   "arandr"
   "autorandr"
   "picom"
   "dunst"
   "fontconfig"
   "lxappearance"

   ;; fonts
   "font-adobe-source-code-pro"
   "font-dejavu"
   "font-fira-code"
   ;;"font-google-noto"
   "font-hack"
   "font-abattis-cantarell"
   "font-awesome"

   ;; icons
   "hicolor-icon-theme"
   "delft-icon-theme"
   "adwaita-icon-theme"
   "arc-icon-theme"
   
   ;; themes
   "arc-theme"
   "gnome-themes-standard"

   "libnotify"
   "wmctrl"
   "xclip"
   "xdotool"
   "xsel"
   "xev"
   "xset"
   "xrdb"
   "xmodmap"
   "setxkbmap"
   "xss-lock"

   "flatpak"
   
   "scrot"
   "lxsession"
   "polkit"
   ;;"mate-polkit"
   "mpv"
   "mpv-mpris"
   "playerctl"
   "libmediainfo"
   "feh"
   "nitrogen"
   "ristretto"
   "viewnior"
   "xwallpaper"
   "flameshot"
   ;;"mupdf"
   ;;"poppler"
   ;;   "libreoffice"
   "zathura"
   "zathura-pdf-mupdf"
   "zathura-djvu"
   "sxiv"
   "gimp"
   "evince"
   ;; need a replacement. brings the whole gnome desktop: "cheese"
   
   ;; editor
   "emacs"
   
   ;; devtools
   ;;   "clojure"
   ;;   "clojure-lsp-bin"
   "cmake"
   "git"
   "go"
   "guile"
   ;;   "leiningen"
   ;; "maven"
   "openjdk@11."
   "tidy"
   ;; TODO enable docker
   ;;   "docker"
   
   ;; browsers
   "qutebrowser"
   "w3m"
   "lynx"
   ;; "ungoogled-chromium"
   "icecat"
   ;;   "firefox"
   
   ;; network tools
   "transmission" ;; out and gui
   "youtube-dl"

   ;; apps from systray
   "clipit"
   "network-manager-applet"
   "system-config-printer"

   ;; tools
   "redshift"
   ;;"gucharmap"
   ;;"fontmanager"
   "brightnessctl"
   "xdg-utils"      ;; For xdg-open, etc
   "xdg-dbus-proxy" ;; For Flatpak
   "gtk+:bin"       ;; For gtk-launch
   "glib:bin"       ;; For gio-launch-desktop
   "shared-mime-info"

   ;; remote access
   "freerdp"
   "rdesktop"
   "vinagre" ;; remmina not present
   
   ))

;; others
;; 
;;   "xorg-server"
;;   "xf86-video-intel"
;;   "xorg-xinit"
;;   "xorg-xrandr"
;;   "xorg-xsetroot"
;;   "acpi"
;;   "acpid"
;;   "xf86-input-libinput"
;;   "xorg-xinput"


;; not found:
;; qt5-webengine-widevine ;; qute support for drm
;;"pdfjs" ;; used by qutebrowser to display pdf inline
;; "wmname" ;; dont think I use this now
;; "dragon-drag-and-drop" ;; drag/drop from terminal
;; "slip" ;; screenshot with dmenu
;; "libxft-bgra" ;; fixes for color emoji in st, dwm, dmenu (crashes)
;; dbus-broker dbus for dwm
;; mydwm
;; mydmenu
;; myst
;; mydwmstatus
;;  printer / scanner
