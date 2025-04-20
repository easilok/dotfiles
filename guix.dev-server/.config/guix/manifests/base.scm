;; -*- mode: guix-scheme-*-

(specifications->manifest
 '(
   "coreutils"
   "gnupg"
   "pinentry"

   ;; These should be global?
   "gcc-toolchain"
   "make"
   "libtool"
   "binutils"
   
   ;; network tools
   "curl"
   "rsync"
   "git"
   "bind:utils" ;; nslookup and dig
   "nss-certs"  ;; lets encrypt certs

   ;; file mgmt
   "unzip"
   "zip"
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
   "jq"
   "tmux"
   "stow"
   "eza"
   "recutils"))
