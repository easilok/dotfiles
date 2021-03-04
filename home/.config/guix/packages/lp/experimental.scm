(define-module (lp experimental)
 #:use-module (guix packages)
 #:use-module (guix git-download)
 #:use-module (guix utils)
 #:use-module (gnu packages xdisorg)
 #:use-module (gnu packages gtk)
 #:use-module (guix status)
 #:use-module (guix build-system gnu)
 )

(define-public my-clipmenu
  (package
   (inherit clipmenu)
   (version "6.2.0")
   (source
    (origin
     (method git-fetch)
     (uri
      (git-reference
       (url "https://github.com/cdown/clipmenu")
       (commit "7c34ace1fbab76eb1c1dc9b30dd4ac1a7fe4b90b")))
     (sha256
      (base32
       "1403sw49ccb8xsd8v611fzp0csaglfz8nmz3wcjsk8x11h9jvxwy"))))
   )
)
	   
(define-public my-clipit
  (package
   (inherit clipit)
   (version "1.4.5")
   (source
    (origin
     (method git-fetch)
     (uri
      (git-reference
       (url "https://github.com/CristianHenzel/ClipIt")
       (commit "c717a0f48db0b16914480ed866be699282be9018")))
     (sha256
      (base32
       "1frnijp7hb337bwwpml5nixihr591h37aamzknkgaxc36fsrjkpi"))))
    (arguments
      '(#:configure-flags '("--with-gtk3")))
    (inputs
     `(("gtk+" ,gtk+))) ;; this is for gtk3, the current version. When gtk4 arrives need fix maybe?
)
)
	   
