;; -*- mode: guix-scheme-*-

(specifications->manifest
 '(
   "coreutils"
   "gnupg"
   "pinentry"

   ;; These should be global?
   "gcc-toolchain"
   "make"
   "cmake"
   "pkg-config"
   
   ;; network tools
   "borg"
   "curl"
   "rsync"
   "git"
   "bind:utils" ;; nslookup and dig
   "le-certs"   ;; lets encrypt certs
   "nss-certs"  ;; lets encrypt certs
   "sshpass"
   "wireguard-tools"

   ;; file mgmt
   "unzip"
   "zip"
   "ranger"
   "bubblewrap"
   "bash-completion"
   "findutils"
   "gzip"
   "pbzip2" ;; multi core replacement for bzip2/bunzip2
   "diffutils"

   ;; system monitoring
   "htop"
   "strace"
   "lsof"
   "sysstat"

   ;; console tools
   "bc" ;; calculator
   "password-store"

   ))

   ;; NOT FOUND
   ;; "gotop"
