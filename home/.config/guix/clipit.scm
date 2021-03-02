(use-modules
 (guix packages)
 (guix git-download)
 (guix utils)
 (gnu packages gtk)
 (guix build-system gnu)
 (guix status)
 )

;; (define clipit-1.4.5
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
;;)
	   
