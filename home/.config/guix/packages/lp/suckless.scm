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
       "127wqlnrbi5zwz598vqdv7pa6r981ks9j9s8s1rmwr9l1m3rnffs"))))))

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
       "127wqlnrbi5zwz598vqdv7pa6r981ks9j9s8s1rmwr9l1m3rnffs"))))))

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
       "127wqlnrbi5zwz598vqdv7pa6r981ks9j9s8s1rmwr9l1m3rnffs"))))))
