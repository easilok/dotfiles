(use-modules
 (guix packages)
 (guix git-download)
 (guix utils)
 (gnu packages xdisorg)
 )

;; (define clipmenu-6.2.0
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
;;)
	   
