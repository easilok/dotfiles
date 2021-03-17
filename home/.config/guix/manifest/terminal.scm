;; -*- mode: guix-scheme-*-

(specifications->manifest
 '(
   ;; sound tools
   "alsa-plugins:out" ;; required by qutebrowser to play audio
   "alsa-plugins:pulseaudio" ;; required by qutebrowser to play audio. missing LD_LIBRARY_PATH
   "alsa-utils"
   "pulsemixer"
   "pamixer"
   "gst-plugins-base"
   "gst-plugins-good"
   "gst-plugins-bad"
   "gst-plugins-ugly"
   "intel-vaapi-driver"
   "gstreamer"

   ;; network tools
   "isync"
   "mu"
   "neomutt"
   "owncloud-client"

   ;; devices
   "dosfstools" ;; create, check and label file systems of the FAT family.
   "numlockx"

   ;; audio / video / media
   "ffmpeg"
   "flac"
   "gawk"
   "imagemagick"
   "sox"

   "fortune-mod"
   "zsh-autosuggestions"

   ;; text manipulation / processing
   "highlight"
   "pandoc"
   "dos2unix"
   "cowsay"
   "recutils" ;; piping tools like recsel

   ;; file processing
   "fzy"
   "go-github-com-junegunn-fzf"
   "jq"
   "mediainfo"
   "pv" ;; pipe progress monitor
   ;; "ripgrep"

   ;; spell checker
   "aspell"
   "aspell-dict-en"
   "aspell-dict-pt-pt"


   ))

;; not found:
;; - iptables: system configuration
;; - dateutils: https://github.com/hroptatyr/dateutils/issues
;; "starship" ;; prompt
