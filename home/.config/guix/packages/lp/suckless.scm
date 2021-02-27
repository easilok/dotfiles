;; -*- mode: guix-scheme-*-

(define-module (lp suckless)
 #:use-module (guix packages)
 #:use-module (guix git-download)
 #:use-module (gnu packages suckless))

(define-public my-dmenu
  (package
   (inherit dmenu)
   (name "my-dmenu")
   (version "latest")
   (source
    (origin
     (method git-fetch)
     (uri
      (git-reference
       (url "https://gitlab.com/easilok/dmenu")
       (commit "746f0468e669da3397afc6e8f6fb1223f30cc6f7")))
     (file-name
      (git-file-name name version))
     (sha256
      (base32
       "091l2vb1y3qd0g6r3wwzm55lddk6g3c7nh840xz1c2v7a4ykhcm7"))))))

(define-public my-dwm
  (package
   (inherit dmenu)
   (name "my-dwm")
   (version "latest")
   (source
    (origin
     (method git-fetch)
     (uri
      (git-reference
       (url "https://gitlab.com/easilok/dwm")
       (commit "c77b3854f9d71750c9663ad2e10649944eea633f")))
     (file-name
      (git-file-name name version))
     (sha256
      (base32
       "1yc3nsbjhs6q2sg6s25dw1qg2rixpxf2fsg588mksvjcj086vc2r"))))))

(define-public my-dwmblocks
  (package
   (inherit dmenu)
   (name "my-dwmblocks")
   (version "latest")
   (source
    (origin
     (method git-fetch)
     (uri
      (git-reference
       (url "https://gitlab.com/easilok/dwmblocks")
       (commit "0fdc485e2313b0f9949b2553d199262d76d10c86")))
     (file-name
      (git-file-name name version))
     (sha256
      (base32
       "03nsbjgknbkm9ybz9m4m0d6y950hyy8majdjj8kqnh1bvzbb4ns5"))))))
